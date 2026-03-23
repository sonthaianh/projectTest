# Research Progress: Add English version of the standardized research prompt

## 1. Session information
- Expert role in use: AI prompt design and research workflow specialist
- Language in use: English
- Current learner level: Already has a strong Vietnamese prompt and needs an equivalent English version
- Session goal: Create an English version of the current strongest research prompt without losing any important logic, trust rules, or teaching structure

## 2. Problem being researched
- Main topic: Translating and standardizing the research prompt into English
- Research scope:
  - preserve the original structure;
  - preserve Research Mode and Implementation Mode;
  - preserve trust and citation requirements;
  - preserve user-onboarding flow;
  - preserve progress-note and unresolved-question behavior.
- Current assumptions:
  - the English version should be usable as a direct copy-paste prompt;
  - the English version should match the upgraded Vietnamese version, not the earlier draft;
  - the prompt should remain portable across different AI platforms.
- Missing data:
  - whether the user wants an additional shorter English version later;
  - whether the user wants a more formal “system prompt” style version next.

## 3. Knowledge clarified
- A direct translation is not enough if it changes tone or drops structural rules.
- The English version must keep the same logic around:
  - role selection;
  - language confirmation;
  - question decomposition;
  - source cross-checking;
  - stable vs experimental distinction;
  - fact vs inference vs recommendation;
  - unresolved questions at the end.

## 4. Main analysis
- Root cause:
  - the user now needs portability across languages, not just prompt quality in one language.
- Working mechanism:
  - use the strongest current Vietnamese prompt as the single source of truth;
  - translate faithfully while preserving intent and instruction hierarchy;
  - add the new English file into the documentation structure so the repo stays easy to navigate.
- Related components:
  - `docs/research-skill-prompt.md`
  - `docs/research-skill-prompt-en.md`
  - `README.md`

## 5. Options considered
| Criteria | Option A: Short English summary only | Option B: Full English prompt equivalent | Notes |
|---|---|---|---|
| Completeness | Low | High | Option B preserves all logic |
| Reusability | Medium | High | Option B can be pasted directly into tools |
| Consistency with Vietnamese version | Low | High | Option B is much better |
| Risk of missing rules | High | Low | Option B is safer |
| Fit for current need | Medium | Very high | Option B clearly matches the request |

## 6. Chosen direction
- Selected option: Full English prompt equivalent
- Why this was chosen:
  - it gives the user a directly usable English version;
  - it preserves the strongest current prompt behavior;
  - it keeps the bilingual documentation set consistent.
- Why other options were not chosen:
  - a shorter or partial translation would likely lose important constraints and reduce prompt reliability.
- Risks to watch:
  - future edits should keep Vietnamese and English versions aligned;
  - if the prompt evolves further, both language versions must be updated together.

## 7. Self-check questions
1. Does the English prompt preserve the exact research flow of the Vietnamese prompt?
2. Does it still clearly separate verified facts, inference, and recommendations?
3. Does it maintain the “do not code unless asked” rule?

## 8. Practice or next action
- Small exercise:
  - Paste the English prompt into another AI system and test whether it begins by asking for role, language, topic, and final goal.
- User action:
  - Open `docs/research-skill-prompt-en.md` and try it in a fresh English-language research session.
- Expected result:
  - the AI should follow the same disciplined research process as in the Vietnamese version.

## 9. Still unclear / needs verification
- Whether the user also wants:
  - a short English version;
  - a stricter English system-prompt version;
  - English role-specific variants in the future.

## 10. Next steps
1. If needed, create a shorter English prompt for daily use.
2. If needed, create a stricter English system prompt version.
3. Keep the Vietnamese and English prompts synchronized in future revisions.
