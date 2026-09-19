# Curriculum Vitae — Rizqika Mulia Pratama

[![Build CV PDFs](https://github.com/rizqikapratamaa/curriculum-vitae/actions/workflows/build-pdf.yml/badge.svg)](https://github.com/rizqikapratamaa/curriculum-vitae/actions/workflows/build-pdf.yml)

Greater Bandung, ID · [rizqikamuliapratama@gmail.com](mailto:rizqikamuliapratama@gmail.com) · [itsqika.com](https://itsqika.com) · [linkedin.com/in/qika](https://linkedin.com/in/qika/) · [github.com/rizqikapratamaa](https://github.com/rizqikapratamaa)

A single-source LaTeX CV: every fact is written once in `content/`, and each file in `variants/` composes those pieces into a role-targeted PDF.

## Download

| Variant | PDF | Framing |
| --- | --- | --- |
| Full | [Rizqika_Mulia_Pratama_-_Full.pdf](pdf/Rizqika_Mulia_Pratama_-_Full.pdf) | Complete CV, generalist summary |
| Software Engineer | [Rizqika_Mulia_Pratama_-_Software_Engineer.pdf](pdf/Rizqika_Mulia_Pratama_-_Software_Engineer.pdf) | Backend and full-stack delivery |
| AI/ML Engineer | [Rizqika_Mulia_Pratama_-_AI_ML_Engineer.pdf](pdf/Rizqika_Mulia_Pratama_-_AI_ML_Engineer.pdf) | Applied ML, LLM/RAG research, MLOps |
| Data Engineer | [Rizqika_Mulia_Pratama_-_Data_Engineer.pdf](pdf/Rizqika_Mulia_Pratama_-_Data_Engineer.pdf) | ETL, pipelines, data governance |

These links resolve once the first CI run has committed the PDFs to `pdf/`.

## Building locally

Requires a TeX distribution with `latexmk` and the `newtx` fonts (TeX Live full, or MacTeX). **Compile from the repository root** — the include paths are root-relative.

```sh
latexmk -pdf -outdir=build variants/full.tex
latexmk -pdf -outdir=build variants/software-engineer.tex
latexmk -pdf -outdir=build variants/ai-ml-engineer.tex
latexmk -pdf -outdir=build variants/data-engineer.tex
```

Output lands in `build/` (gitignored). Clean up with `latexmk -C -outdir=build variants/full.tex`.

## How the single source works

```
content/     one fact, one place — header, education, each role, each project, skills
variants/    composition only — summary paragraph, section order, which files to \input
template/    resume.cls — shared styling for all variants
pdf/         compiled output, committed by CI
```

Two mechanisms let variants differ without duplicating text:

1. **Selection and order.** A variant `\input`s only the entries it wants, in the order it wants. Delegasi.co appears in the Full and Software Engineer CVs only; the AI/ML CV puts Education first so the thesis leads.

2. **Tagged bullets.** Within a shared file, individual bullets are gated by variant tag:

   ```latex
   \cvitemif{full,softeng,ai,data}{Developed and maintained cross-platform apps...}
   \cvitemif{ai}{Owned the model lifecycle end to end: prompt and retrieval design...}
   ```

   Valid tags are `full`, `softeng`, `ai`, and `data`; each variant declares its own via `\cvsetvariant{...}`. Matching is literal with no wildcard, so two phrasings of the same fact can never both render — give them non-overlapping tag lists. `\cvonly{tags}{...}` does the same for a whole block.

   Note: every entry a variant includes must leave **at least one** bullet enabled, or LaTeX errors on the empty list.

### Adding a new variant

1. Add tags for the new role to the relevant bullets in `content/`.
2. Create `variants/<role>.tex` — set `\cvsetvariant{<tag>}`, write the summary, `\input` the sections you want.
3. Add the file to `root_file` and a `rename_to` line in `.github/workflows/build-pdf.yml`, plus a row in the table above.

## Automation

`.github/workflows/build-pdf.yml` runs on any push to `main` touching `content/**`, `variants/**`, or `template/**`. It compiles all four variants, renames them to `Rizqika_Mulia_Pratama_-_<Variant>.pdf`, and commits them back to `pdf/` on `main` so they can be linked directly. The commit is marked `[skip ci]` and `pdf/` is outside the path filter, so it will not retrigger itself.
