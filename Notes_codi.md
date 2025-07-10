


POSAR CONDICIONAL EN APP SELECCIÓ EN SHORTKEYS NOMÈS SI ELS BOTONS DE SELECCIÓ SÓN PRESENTS (app.Button.Visible)

# Notes sobre la modificació del codi

https://code.visualstudio.com/docs/languages/markdown

## Millora codi programa  
- [ ] Traduir funcions noms + compartimentar i traduir apps.
- [ ] Veure que no hi hagi "ççç" ni "ñññ" marques + "Josep".
- [ ] Mirar si esquelet hi ha més d'un branchpoint: error de que es selecciona cadena de més
- [ ] Borrar la carpeta a posteriori de fer l'anàlisi?
- [ ] (una vegada amb DOI i paper): -> Posar "Please cite us" i enllaç en l'App de resultats finals.

### Possibles Issues
- [ ] Quan es canvia la grandària a resultats estadística es col·lapsa el programa.
- [ ] Quan es fa Done i no hi ha cap seleccionat, en fer return dona error.
- [ ] Si hi ha seleccionat  modificacions guardades, no es puguin modificar (al canviar imatge permèt modificar...).
- [ ] Comprovar amb imatges amb diferent resolució (segurament dona error).


- [X] ~~Canviar posicions de introduccio de text i de box de selecció.~~  
- [X] ~~Variable de la app de selecció *global_temps_total_inici* definir origen i funció.~~

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



## Storic function name change

**Functions**:  
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
quadre_decisio_modif -> decision_box_modif  
agregar_zeros -> add_zeros  
bwareaopen_percentatge -> bwareaopen_percentage  
compara_BW_objecte_coincident -> compare_BW_coincident_object  
compara_en_carpeta_nom_BW_coincident -> compare_BW_coincident_infolder  
copia_dades -> data_copy_own  
correccio_sortida_dimensios -> dimension_output_correction  
determina_path_zip -> determine_path_zip  
ditancia_varis_punts -> distance_many_points  
eixamplar_imgBW -> wide_imgBW  
escala_determinar -> scale_determine  
esquel_multiple_BWobjects -> skel_multiple_BWobjects  
extendre_img_regions -> extend_img_regions  
ficar_marges -> margins_put  
ficar_text_imatge -> put_txt_to_img  
graficar_rgbgraybw_image -> graph_rgbgraybw_image  
identifica_pump_anterior_nou -> identify_pump_previous_new  
identifica_round_obj -> identify_round_obj  
imatge_sense_objectes -> image_without_objects  
introduir_dades_posvar -> introduce_data_posvar  
introduir_dades -> introduce_data  
lectura_criba_fitxers_ocults -> lecture_sift_hide_files  
llegir_arxius_tipologia -> read_files_typology  
lectura_imatges_carpeta_estr -> read_imgs_folder_structure  
llegir_dades -> read_data  
lectura_txt_carpeta_estr -> read_txt_folder_structure  
llegir_text_delimitadors -> read_text_delimiters  
matriu_nova -> matrix_new  
obtencio_tipologia_llistat -> obtain_list_typology  
obtenir_array_processaments -> obtain_array_processments  
obtenir_de_txt_valor_string -> obtain_from_txt_string  
obtenir_distancies_BWskel -> obtain_distances_BWskel  
obtenir_major_conected -> obtain_major_connected  
obtenir_num_BW -> obtain_num_BW  
percentatge_imatge -> img_percentage  
pintar_BB_img_eix -> paint_BB_img_axis  
pintar_BB_img -> paint_BB_img  
processament_imatge_llistat -> processment_img_list  
retallar_BWRGBimatge_BB_nou -> cut_BB_BW_RGB_image  
retallar_BWimatge_BB_2 -> cut_BB_BW_image_2  
retallar_BWimatge_BB -> cut_BB_BW_image_1  
retallar_BB_BWimg -> cut_BB_BW_image_3  
retallar_imatges_punts -> cut_imgs_points  
retorna_zeros_un -> return_zeros_one  
retorna_zeros -> return_zeros_five  
separacio_imatges_binaries -> divide_imgs_binary  
separar_file_carpeta -> divide_file_folder  
separar_puntfile_nou -> divide_pointfile_large  
separar_puntfile -> divide_pointfile  
suma_semiBW_norm_millorat -> superpose_semiBW_RGB  
sumar_un_a_txt_valor_string -> sum_a_txt_str_value  
tipus_rgbgraybw_image -> type_rgbgraybw_image  
juntar_BB_imatge -> join_BB_image  
eixamplar_indx_BB -> wide_indx_BB  
eixamplar_indx_noendpoints -> wide_indx_nonendpoints  
escalar_indx -> scale_indx  
pintar_indx_to_RGB -> paint_indx_to_RGB  
print_RGB_indx_brush -> print_RGB_indx_brush  
determinacio_paquets -> determine_packages  
veure_si_instalat -> look_if_installed  
creacio_S_textscan_modifs -> create_S_textscan_modifs  
tipologia_formatspec_table_separador -> typology_formatspec_table_sep  
tipologia_formatspec_table -> typology_formatspec_table_norm  
cell_insert_valors -> cell_insert_values  

<br>

**Folders**:  
imatges_utilitat -> images_useful  
funcions_app -> functions_app  
funcions_botons_nous -> functions_new_buttons  
taules_modificacio -> tables_modification  
Actualitzacio_botons -> Update_buttons  
Imatge -> Image  
execucio_processament_imatge -> image_processment_execution  
graficacio_botons -> buttons_graphication  

<br>

**Apps**:  
app_escala_auto -> app_scale_auto  
app_escala_linia -> app_scale_line  
box_correccio_Fiji -> box_manual_correction  
box_explicacio_IA -> box_IA_explanation  
