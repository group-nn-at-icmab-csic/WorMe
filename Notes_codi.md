


POSAR CONDICIONAL EN APP SELECCIÓ EN SHORTKEYS NOMÈS SI ELS BOTONS DE SELECCIÓ SÓN PRESENTS (app.Button.Visible)

# Notes sobre la modificació del codi

https://code.visualstudio.com/docs/languages/markdown

## Millora codi programa  
- [ ] Traduir funcions noms + compartimentar i traduir apps.
- [ ] Si hi ha seleccionat  modificacions guardades, no es puguin modificar (al canviar imatge permèt modificar...).
- [ ] Mirar si esquelet hi ha més d'un branchpoint: error de que es selecciona cadena de més
- [ ] Variable de la app de selecció *global_temps_total_inici* definir origen i funció.
- [ ] Borrar la carpeta a posteriori de fer l'anàlisi?
- [ ] Quan es fa Done i no hi ha cap seleccionat, en fer return dona error.
- [ ] Botó exit de app selection pannel en la part de results tarda molt: posar en que tanqui directament o corregir.
- [ ] Comprovar amb imatges amb diferent resolució (segurament dona error).
- [ ] (una vegada amb DOI i paper): -> Posar "Please cite us" i enllaç en l'App de resultats finals.

- [X] ~~Canviar posicions de introduccio de text i de box de selecció.~~

### ! Vigilar al modificar el codi! 👀

- Programes de cerca 🔍  com Fileseek **no troven els noms en les apps de MATLAB** . Això vol dir que si es busca una funció o nom d'arxiu en concret dins del programa, no es trovarà si aquesta és o es menciona dins d'una app.




## Canviar codi

**app_interf_video_demostratiu**: Fa que el vídeo s'obri dins del box. Revisar treure?.

- Botó retornar a menú de selecció d'escala (tornar des de selecció automatica, selecció manual, i selecció numèrica).

- Posar botó per a cada funció de processament d'imatge

- Posar test de normalitat de les dades

- provar en IOs (Apple)
- Provar en Linux

- Posar text en funcions
- Treure Deteccio automàtica?

- Adaptar a imatges en escala de grisos.

- Cambiar icono excel (libre office)
- Opció descarregar un .csv (separat per coma)

- posar descripció en quadre automàtic al passar a sobre de tecles com tisores, allargar, etc. Que expliqui què fan. O posar imatge explicativa, o en GIF.

- Treure el Max Circularity (ocultar-lo)

- Min area : Explicar més? Donar valors de referència.

- Posar Max length









## Comprovacións pendents

 
#### Temps post-instalació
- [] Quan es compila el programa i s'instala, cada vegada va més ràpid. Determinar l'agilitat percentual d'iniciació i ús del programa., és a dir, quantes vegades tarda menys temps en funcionar. 
A què es deu? Suposem que a l'us en el Runtime.
Millora en noves versións de MATLAB? En teoria hauria de millorar, sí.



## Canvi funcions

REVISAR EN DOCUMENTACIÓ (Ctrl F de tota la carpeta GitHub) I EN LES APPS

Canviat noms funcions:

llargada_josep -> worm_lenght
llargada_josep_Fiji -> worm_length_manual
esqueletonitzacio_josep_optim -> worm_skeletonization
esqueletonitzacio_josep_optim_2 -> worm_skeletonization_manual
write_josep -> write_img_dir
write_text_josep -> write_text_array
extendre_skel_estes_nou -> skel_elongate
play_music_josep -> play_music
edge_canny_josep -> edge_canny_own
cell2array_josep -> cell2array_own

