# Notes sobre la publicació al *Journal of Open Source Software* (JOSS)

#### Article Jordi Faraudo  
[Chitin Builder: a VMD tool for the generation of structures of chitin molecular crystals for atomistic simulations](https://joss.theoj.org/papers/10.21105/joss.05771)  
[Chitin Builder](https://github.com/soft-matter-theory-at-icmab-csic/chitin_builder)  
[Soft Matter Theory Group](https://github.com/soft-matter-theory-at-icmab-csic)  

---

## Tasques pendents  
- [X] **Revisió de les biblioteques de MATLAB (llicència):** Verificar si estan disponibles sota una llicència de codi obert. 
- [X] Decidir llicència (Suggeriment: GNU GPL3 si volem que els derivats hagin de ser codi obert, o MIT o BSD-3-Clause si ens és igual)
- [ ] Escriure article
- [ ] Escriure manual d'usuari
- [ ] Traduir comentaris del codi
- [ ] Provar-ho en Linux i Mac
- [ ] Fer públic el repositori
- [ ] Complir el [Community guideliness](https://joss.readthedocs.io/en/latest/review_criteria.html#community-guidelines): donar criteris per a que 3es persones contribueixin al software, avisin d'errors, i hi hagi el contacte per a si volen i necessiten suport. 


---

## Incloure o no incloure? i a on?
- Contribution Guidelines (Chitin builder inclou un document de com contribuir. Ho volem fer així o escriure-ho directament al readme, o no escriure-ho?)
- Length correction (Manual)
- Export graphic data per IA (Manual)
- Comparar Wormachine, ImageJ, WorMe (Manual? Document suplementari? Article?)

## Requirements

- [X] The software must be open source as per the OSI definition.
- [X] The software must be hosted at a location where users can open issues and propose code changes without manual approval of (or payment for) accounts.
- [X] The software must have an obvious research application.
- [X] You must be a major contributor to the software you are submitting, and have a GitHub account to participate in the review process.
- [ ] Your paper must not focus on new research results accomplished with the software.
- [X] Your paper (paper.md and BibTeX files, plus any figures) must be hosted in a Git-based repository together with your software.

In addition, the software associated with your submission must: (UN COP PÚBLIC)
- [X] Be stored in a repository that can be cloned without registration.
- [X] Be stored in a repository that is browsable online without registration.
- [X] Have an issue tracker that is readable without registration.
- [X] Permit individuals to create issues/file tickets against your repository.

Judging effort
- [ ] Age of software (is this a well-established software project) / length of commit history.
- [X] Number of commits.
- [X] Number of authors.
- [ ] Total lines of code (LOC). Submissions under 1000 LOC will usually be flagged, those under 300 LOC will be desk rejected.
- [ ] Whether the software has already been cited in academic papers.
- [X] Whether the software is sufficiently useful that it is likely to be cited by your peer group.

Before you submit, you should:
- [X] Make your software available in an open repository (GitHub, Bitbucket, etc.) and include an OSI approved open source license.
- [ ] Make sure that the software complies with the JOSS review criteria. In particular, your software should be full-featured, well-documented, and contain procedures (such as automated tests) for checking correctness.
- [ ] Write a short paper in Markdown format using paper.md as file name, including a title, summary, author names, affiliations, and key references. See our example paper to follow the correct format.
- [ ] (Optional) create a metadata file describing your software and include it in your repository. We provide a script that automates the generation of this metadata.

Your paper should include:
- [X] A list of the authors of the software and their affiliations, using the correct format (see the example below).
- [ ] A summary describing the high-level functionality and purpose of the software for a diverse, non-specialist audience.
- [ ] A Statement of need section that clearly illustrates the research purpose of the software and places it in the context of related work.
- [ ] A list of key references, including to other software addressing related needs. Note that the references should include full names of venues, e.g., journals and conferences, not abbreviations only understood in the context of a specific discipline.
- [ ] Mention (if applicable) a representative set of past or ongoing research projects using the software and recent scholarly publications enabled by it.
- [ ] Acknowledgement of any financial support.


## Articles JOSS referència

- [micompm: A MATLAB/Octave toolbox for multivariate independent comparison of observations] (https://github.com/nunofachada/micompm/blob/master/docs/userguide.md)



## Referències i enllaços d'interès sobre JOSS  

- [Cerca d'articles relacionats amb MATLAB a JOSS](https://joss.theoj.org/papers/search?q=matlab&search_button=)  
- [About JOSS](https://joss.theoj.org/about)  
- [Anunci inicial sobre JOSS](https://www.arfon.org/announcing-the-journal-of-open-source-software)
 
- [Llicències Open Source](https://opensource.org/licenses-old/category)  

- [Guia per a la presentació d'articles](https://joss.readthedocs.io/en/latest/submitting.html)  
  > **Nota:** Es recomana revisar la secció *"Before you submit, you should:"*  
- [Review criteria](https://joss.readthedocs.io/en/latest/review_criteria.html)  

--
## Exemple d'article i codi  
- [Repositori a GitHub](https://github.com/ashleefv/ACEInhibPKPD)  
- [Article a JOSS](https://joss.theoj.org/papers/10.21105/joss.00340)  
