# Evidence packets and research state

Read when extracting sources or maintaining continuing research. These are compact schemas, not mandatory empty forms. Omit irrelevant fields; mark consequential missing information as unknown. Use stable source (S1), evidence (E1), hypothesis (H1), and decision (D1) IDs within a project.

## Delegation brief

- Question and uncertainty to resolve; what decision it informs.
- Scope, exclusions, assigned sources or discovery bounds, and relevant state excerpt.
- Output: compact packets with source locators, conflicts, access limits, and highest-value next check.
- A proportional source/time/output budget if needed; stop when the question is answered or evidence is exhausted. Return unresolved issues without padding the packet.

## Evidence packet

**Identity:** E-ID; question addressed; S-ID; full citation (title, authors/publisher, date/version, DOI or original URL when available); file/access pointer; exact page, section, table, figure, or dataset location. Record whether evidence came from full text, abstract, secondary report, or inaccessible source metadata. Never invent missing bibliographic fields or locators.

**Finding:** Narrow claim; whether supported, contradicted, mixed, or not tested; separate author statement, observed result, and analyst inference.

**Quantitative evidence:** Values, units, sample size, denominator, effect size, uncertainty intervals or significance if reported, baseline/comparator, metric direction, population/dataset, and experimental conditions. Distinguish absolute from relative changes. Label calculations as derived and retain inputs. Do not treat unreported uncertainty as zero.

**Method and applicability:** Study design, controls, measurement protocol, assumptions, confounders, validity limits, and relevance to the question. For theoretical work, record premises, result, and proof scope instead of forcing empirical fields.

**Tensions:** Contradictory or negative evidence, plausible alternative explanations, source dependencies, unresolved methodological details, and confidence with a brief reason. Separate uncertainty in the source from uncertainty in interpretation.

**Next check:** The smallest useful verification or discriminating investigation, with why it could matter. Include only if worthwhile.

Keep essential numerical and methodological detail even when shortening prose. One source may produce multiple packets for materially different claims; reference its shared citation instead of duplicating it.

## Compact research state

Maintain a short current-state document with links to larger packet/source stores when needed:

- **Objective and scope:** User question, decision, constraints, deliverable, current mode, and last update.
- **Current answer:** Best supported conclusion, confidence and reasons, and conditions under which it holds.
- **Hypotheses:** H-ID, status (open/supported/weakened/rejected), supporting and opposing E-IDs, assumptions, and what could change status. Rejected hypotheses retain the reason, evidence, and reopening condition; rejection is not deletion.
- **Evidence index:** E-ID → claim/result, key numbers and conditions, S-ID and exact locator or packet link. Source registry retains bibliographic and access information once.
- **Disagreements:** Competing claims/E-IDs, whether differences concern data, methods, scope, or interpretation; current resolution or explicit unresolved status.
- **Decisions:** D-ID, choice, rationale, evidence, alternatives rejected, and revisit trigger. Preserve superseded decisions with a compact pointer.
- **Open questions and next investigations:** Uncertainty, proposed test/source, expected information gain, impact on conclusion, cost/feasibility, priority, and stopping rule.
- **Coverage and limits:** Sources searched/read, unavailable material, important exclusions, and remaining budget if one was set.

On resume, load current state and relevant packets only. Reopen original material for verification, conflict resolution, or missing methodological detail. Ensure every consequential conclusion remains traceable through evidence to its original source.
