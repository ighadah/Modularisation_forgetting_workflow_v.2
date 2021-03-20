# Modularisation forgetting workflow v.2

The workflow extracts views of an ontology by the combination of the following:
* Signature Extension
* Modularisation
* Forgetting
* Post processing methods: denormalisation, and adding annotations.

The workflow starts with two inputs from the user which are: 
  * The signature file, (a list of concept and/or role names) 
  * The ontology file<br/>
  
1. **Signature extension method**

The method extends the input signature by using the information in the input ontology according to an input depth number (which ranges from 0 to 2). Example: 
Sigma = {A}, O = {A <= (B1) and (r some B2) and (s some (t some B3))} 
The method computes extended signature sets 
* Sigma+\_0 = {A, B1}
* Sigma+\_1 = {A, B1, B2, r}
* Sigma+\_2 = {A, B1, B2, r, s, t, B3}

The method works with ELH ontologies where the axioms are of the form A <= C or A == C where C is a complex class expression, or of the form r <= s where r and s are role names.

2. **Modularisation**

The method uses the chosen extended signature set (which can be 0, 1, or 2) and use it to extract STAR module from the input ontology. 
The tool used: OWL API syntactical locality based modularisation tool (STAR modules type). OWL API version: 4.1.0

3. **Forgetting**

The method forgets from the computed star module the signature that is outside of the extended signature. The outout is a view that precisely describes the information in the range of the extended signature.<br/>
The tool used: LETHE version 0.6 (2020-02-28) link: https://lat.inf.tu-dresden.de/~koopmann/LETHE/

4. **Post processing**

Since the axioms generated from the forgetting tool are normally normalised. It's preferable to denormalise them, to preserve the original form of the axioms of the original ontology. The denormalisation in the workflow is done according to the following two logical rules: <br/>
* if A <= B1 and A <= B2 then A <= B1 and B2 
* if C <= A and A <= C then A == C. <br/>
As part of the post processing methods, annotations (labels) of concepts are added to the resulting views. <br/>

**Paper:** Ontology Extraction for Large Ontologies via Modularity and Forgetting. J. Chen, G. Alghamdi, R. Schmidt, D. Walther and Y. Gao. In Kejriwal, M. and Szekely, P. A. and Troncy, R. (eds), Proceedings of the 10th International Conference on Knowledge Capture (K-CAP'19). ACM, 45-52.
http://www.cs.man.ac.uk/~schmidt/publications/ChenAlghamdiEtAl19a.pdf
