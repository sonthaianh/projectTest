using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;

namespace MsiInstaller
{
    class Program
    {
        private const string LogFileName = "install_history.log";

        static int Main(string[] args)
        {
            List<string> msiFiles = new List<string>();

            // 1. Parse Arguments
            if (args.Length == 0)
            {
                Console.WriteLine("Usage: MsiInstaller.exe <file1.msi> <file2.msi> ...");
                Console.WriteLine("   Or: MsiInstaller.exe -ListFile list.txt");
                return 0;
            }

            if (args.Length == 2 && args[0].Equals("-ListFile", StringComparison.OrdinalIgnoreCase))
            {
                string listPath = args[1];
                if (!File.Exists(listPath))
                {
                    Log($"ERROR: List file not found: {listPath}", ConsoleColor.Red);
                    return 1;
                }
                msiFiles.AddRange(File.ReadAllLines(listPath)
                    .Where(l => !string.IsNullOrWhiteSpace(l) && !l.Trim().StartsWith("#"))
                    .Select(l => l.Trim()));
            }
            else
            {
                msiFiles.AddRange(args);
            }

            if (msiFiles.Count == 0)
            {
                Log("No files to install.", ConsoleColor.Yellow);
                return 0;
            }

            Log("--- STARTING BATCH INSTALLATION (C#) ---", ConsoleColor.Cyan);

            // 2. Process Loop
            foreach (string msiPath in msiFiles)
            {
                string fullPath = Path.GetFullPath(msiPath);
                
                Log("----------------------------------------");
                
                if (!File.Exists(fullPath))
                {
                    Log($"ERROR: File not found '{fullPath}'. Aborting.", ConsoleColor.Red);
                    return 1;
                }

                Log($"Installing: {Path.GetFileName(fullPath)}...", ConsoleColor.Yellow);

                // Prepare log file for msiexec
                string msiLogFile = $"{Path.GetFileNameWithoutExtension(fullPath)}_verbose.log";
                string arguments = $"/i \"{fullPath}\" /quiet /norestart /l*v \"{msiLogFile}\"";

                try
                {
                    ProcessStartInfo psi = new ProcessStartInfo
                    {
                        FileName = "msiexec.exe",
                        Arguments = arguments,
                        UseShellExecute = false,
                        CreateNoWindow = true
                    };

                    using (Process process = Process.Start(psi))
                    {
                        process.WaitForExit();
                        int exitCode = process.ExitCode;

                        if (exitCode == 0)
                        {
                            Log($"SUCCESS: Installed {Path.GetFileName(fullPath)}", ConsoleColor.Green);
                        }
                        else if (exitCode == 3010)
                        {
                            Log($"WARNING: Installed {Path.GetFileName(fullPath)} (Reboot Required). Continuing...", ConsoleColor.Yellow);
                        }
                        else
                        {
                            Log($"CRITICAL FAILURE: Failed to install {Path.GetFileName(fullPath)}. Exit Code: {exitCode}", ConsoleColor.Red);
                            Log($"Check '{msiLogFile}' for details.", ConsoleColor.Red);
                            Log("ABORTING REMAINING INSTALLATIONS.", ConsoleColor.Red);
                            return exitCode;
                        }
                    }
                }
                catch (Exception ex)
                {
                    Log($"EXCEPTION: {ex.Message}", ConsoleColor.Red);
                    return 1;
                }
            }

            Log("----------------------------------------");
            Log("ALL INSTALLATIONS COMPLETED SUCCESSFULLY.", ConsoleColor.Green);
            return 0;
        }

        private static void Log(string message, ConsoleColor color = ConsoleColor.White)
        {
            string timestamp = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            string formattedMsg = $"[{timestamp}] {message}";

            // Write to Console
            ConsoleColor oldColor = Console.ForegroundColor;
            Console.ForegroundColor = color;
            Console.WriteLine(formattedMsg);
            Console.ForegroundColor = oldColor;

            // Write to Log File
            try
            {
                File.AppendAllText(LogFileName, formattedMsg + Environment.NewLine);
            }
            catch
            {
                // Ignore log file write errors to avoid crashing the main logic
            }
        }
    }
}
