:- encoding(utf8).
% =====================================================================
% Actividad 3 - Asignación de profesores
% Facultad de Ciencias de la Información, UNACAR
%
% Sistema basado en conocimiento en Prolog con un servidor web que
% expone una API REST (JSON) y vistas HTML.
%
% Para ejecutarlo (requiere SWI-Prolog):
%   swipl -s actividad3.pl
% Se abre una consola con el servidor corriendo en el puerto 8080.
% Abrir en el navegador:  http://localhost:8080/home
% O usar el menú en consola: escribir  menu.  en la consola de Prolog.
% Detener el servidor, desde la consola abierta:  http_stop_server(8080, []).
% Salir:  halt.
% =====================================================================
:- discontiguous area_de/2.

% =====================================================================
% 1. BASE DE CONOCIMIENTO
% =====================================================================

% ---------------------------------------------------------------------
% Áreas de conocimiento (sirven para comparar perfiles con entidades)
% area(Id, Nombre).
% ---------------------------------------------------------------------
area(software,                'Ingeniería de software').
area(bases_datos,             'Bases de datos').
area(redes,                   'Redes de computadoras').
area(seguridad,               'Seguridad informática').
area(inteligencia_artificial, 'Inteligencia artificial').
area(matematicas,             'Matemáticas').
area(multimedia,              'Multimedia').
area(educacion,               'Educación').
area(general,                 'General').

% ---------------------------------------------------------------------
% Profesores
% profesor(NumEmpleado, Nombre, GradoAcademico, Especialidad,
%          CursosQueDomina)   % lista ordenada de MAYOR a MENOR dominio
% ---------------------------------------------------------------------
profesor(1001, 'Ana Martínez Cruz',       doctorado,    inteligencia_artificial, [ia101, prog201, mat101]).
profesor(1002, 'Luis Hernández Pérez',    maestria,     redes,                   [red101, red201, seg101]).
profesor(1003, 'María López Gómez',       doctorado,    bases_datos,             [bd101, bd201, prog101]).
profesor(1004, 'Carlos Ramírez Díaz',     maestria,     software,                [prog201, is101, prog101, web101]).
profesor(1005, 'Sofía Torres Méndez',     licenciatura, multimedia,              [mm101, web101]).
profesor(1006, 'Jorge Castillo Ruiz',     doctorado,    matematicas,             [mat101, mat201, ia101]).
profesor(1007, 'Elena Vázquez Ortiz',     maestria,     seguridad,               [seg101, red101, bd101]).
profesor(1008, 'Ricardo Morales Sánchez', maestria,     educacion,               [fi101, prog101, mm101]).

% ---------------------------------------------------------------------
% Estudios: licenciatura, maestría y doctorado
% estudio(NumEmpleado, Nivel, Titulo, Institucion, Area).
% ---------------------------------------------------------------------
estudio(1001, licenciatura, 'Ingeniería en Computación',              'UNACAR',  software).
estudio(1001, maestria,     'Maestría en Ciencias Computacionales',   'INAOE',   inteligencia_artificial).
estudio(1001, doctorado,    'Doctorado en Ciencias de la Computación','INAOE',   inteligencia_artificial).
estudio(1002, licenciatura, 'Ingeniería en Sistemas Computacionales', 'Instituto Tecnológico de Campeche', redes).
estudio(1002, maestria,     'Maestría en Redes y Telecomunicaciones', 'UADY',    redes).
estudio(1003, licenciatura, 'Licenciatura en Informática',            'UNACAR',  bases_datos).
estudio(1003, maestria,     'Maestría en Tecnologías de Información', 'UNACAR',  bases_datos).
estudio(1003, doctorado,    'Doctorado en Ciencias de la Información','UNAM',    bases_datos).
estudio(1004, licenciatura, 'Ingeniería en Sistemas Computacionales', 'UNACAR',  software).
estudio(1004, maestria,     'Maestría en Ingeniería de Software',     'CIMAT',   software).
estudio(1005, licenciatura, 'Licenciatura en Diseño Gráfico',         'UADY',    multimedia).
estudio(1006, licenciatura, 'Licenciatura en Matemáticas',            'UADY',    matematicas).
estudio(1006, maestria,     'Maestría en Matemáticas Aplicadas',      'CIMAT',   matematicas).
estudio(1006, doctorado,    'Doctorado en Ciencias Matemáticas',      'UNAM',    matematicas).
estudio(1007, licenciatura, 'Ingeniería en Computación',              'UNACAR',  redes).
estudio(1007, maestria,     'Maestría en Seguridad Informática',      'IPN',     seguridad).
estudio(1008, licenciatura, 'Ingeniería en Sistemas Computacionales', 'UNACAR',  software).
estudio(1008, maestria,     'Maestría en Educación',                  'UNACAR',  educacion).

% ---------------------------------------------------------------------
% Acreditaciones / certificaciones
% acreditacion(NumEmpleado, Nombre, Organismo, Area).   (general = aplica a todo)
% ---------------------------------------------------------------------
acreditacion(1001, 'Perfil Deseable PRODEP',                 'SEP',       general).
acreditacion(1001, 'SNII Nivel I',                           'SECIHTI',   inteligencia_artificial).
acreditacion(1002, 'CCNA',                                   'Cisco',     redes).
acreditacion(1003, 'Perfil Deseable PRODEP',                 'SEP',       general).
acreditacion(1003, 'Oracle Database SQL Certified Associate','Oracle',    bases_datos).
acreditacion(1004, 'Perfil Deseable PRODEP',                 'SEP',       general).
acreditacion(1004, 'Professional Scrum Master I',            'Scrum.org', software).
acreditacion(1006, 'Perfil Deseable PRODEP',                 'SEP',       general).
acreditacion(1007, 'CompTIA Security+',                      'CompTIA',   seguridad).
acreditacion(1007, 'CCNA',                                   'Cisco',     redes).
acreditacion(1008, 'Certificación en Competencias Docentes', 'UNACAR',    educacion).

% ---------------------------------------------------------------------
% Academias
% academia(Id, Nombre, MateriasAsignadas, Lider).
% ---------------------------------------------------------------------
academia(ac_sw,  'Academia de Ingeniería de Software',                  [prog101, prog201, is101, web101], 1004).
academia(ac_bd,  'Academia de Bases de Datos y Sistemas de Información',[bd101, bd201],                    1003).
academia(ac_red, 'Academia de Redes y Seguridad',                       [red101, red201, seg101],          1002).
academia(ac_cb,  'Academia de Ciencias Básicas e Inteligencia Artificial',[ia101, mat101, mat201],         1006).
academia(ac_mm,  'Academia de Multimedia y Formación Integral',         [mm101, fi101],                    1008).

area_de(ac_sw, software).
area_de(ac_bd, bases_datos).
area_de(ac_red, redes).             area_de(ac_red, seguridad).
area_de(ac_cb, matematicas).        area_de(ac_cb, inteligencia_artificial).
area_de(ac_mm, multimedia).         area_de(ac_mm, educacion).

% ---------------------------------------------------------------------
% Cursos (materias a impartir)
% curso(Id, Creditos, Nombre, Objetivo, Academia).
% ---------------------------------------------------------------------
curso(prog101, 8, 'Programación I',                  'Desarrollar algoritmos y programas estructurados', ac_sw).
curso(prog201, 8, 'Programación Orientada a Objetos','Diseñar e implementar programas orientados a objetos', ac_sw).
curso(is101,   7, 'Ingeniería de Software',          'Aplicar metodologías para desarrollar software de calidad', ac_sw).
curso(web101,  7, 'Desarrollo Web',                  'Construir aplicaciones web del lado cliente y servidor', ac_sw).
curso(bd101,   8, 'Bases de Datos',                  'Diseñar e implementar bases de datos relacionales', ac_bd).
curso(bd201,   7, 'Bases de Datos Avanzadas',        'Administrar y optimizar bases de datos relacionales y NoSQL', ac_bd).
curso(red101,  8, 'Redes de Computadoras',           'Comprender los modelos y protocolos de comunicación', ac_red).
curso(red201,  7, 'Administración de Redes',         'Configurar y administrar infraestructura de red', ac_red).
curso(seg101,  7, 'Seguridad Informática',           'Identificar amenazas y aplicar controles de seguridad', ac_red).
curso(ia101,   8, 'Inteligencia Artificial',         'Aplicar búsqueda, razonamiento y aprendizaje automático', ac_cb).
curso(mat101,  8, 'Matemáticas Discretas',           'Aplicar lógica, conjuntos y grafos a la computación', ac_cb).
curso(mat201,  7, 'Probabilidad y Estadística',      'Analizar datos con modelos probabilísticos', ac_cb).
curso(mm101,   6, 'Diseño Multimedia',               'Producir contenidos digitales interactivos', ac_mm).
curso(fi101,   5, 'Ética Profesional',               'Fomentar la responsabilidad ética profesional', ac_mm).

area_de(prog101, software).   area_de(prog201, software).
area_de(is101,   software).   area_de(web101,  software).
area_de(bd101,   bases_datos). area_de(bd201,  bases_datos).
area_de(red101,  redes).      area_de(red201,  redes).
area_de(seg101,  seguridad).
area_de(ia101,   inteligencia_artificial).
area_de(mat101,  matematicas). area_de(mat201, matematicas).
area_de(mm101,   multimedia).
area_de(fi101,   educacion).

% ---------------------------------------------------------------------
% Cuerpos académicos
% cuerpo_academico(Id, Nombre, LineaInvestigacion, Lider, Estatus).
% ---------------------------------------------------------------------
cuerpo_academico(ca01, 'Sistemas Inteligentes',
                 'Aprendizaje automático y modelado matemático', 1001, en_consolidacion).
cuerpo_academico(ca02, 'Ingeniería de Software y Datos',
                 'Desarrollo de software y gestión de la información', 1003, consolidado).
cuerpo_academico(ca03, 'Redes y Seguridad de la Información',
                 'Infraestructura de redes y ciberseguridad', 1002, en_formacion).

area_de(ca01, inteligencia_artificial). area_de(ca01, matematicas).
area_de(ca02, software).                area_de(ca02, bases_datos).
area_de(ca03, redes).                   area_de(ca03, seguridad).

% ---------------------------------------------------------------------
% Proyectos
% proyecto(Id, Nombre, Objetivo, Entregables, Lider, Integrantes,
%          FechaInicio, FechaEntrega).
% proyecto_cupo(Id, MaxIntegrantes)  (sin contar al líder)
% ---------------------------------------------------------------------
proyecto(py01, 'Sistema de alerta temprana de deserción escolar',
         'Predecir el riesgo de abandono escolar con aprendizaje automático',
         ['Modelo predictivo', 'Tablero web', 'Artículo arbitrado'],
         1001, [1006], date(2026, 2, 2), date(2026, 12, 11)).
proyecto(py02, 'Monitoreo y seguridad de la red del campus',
         'Implementar monitoreo y detección de intrusiones en la red de la facultad',
         ['Diagnóstico de red', 'Sistema de monitoreo', 'Manual de políticas'],
         1002, [], date(2026, 8, 17), date(2027, 6, 30)).
proyecto(py03, 'Plataforma de tutorías en línea',
         'Desarrollar una plataforma web para gestionar las tutorías académicas',
         ['Plataforma web', 'Contenidos multimedia', 'Manual de usuario'],
         1004, [1005], date(2026, 9, 1), date(2027, 5, 29)).

proyecto_cupo(py01, 3).
proyecto_cupo(py02, 2).
proyecto_cupo(py03, 3).

area_de(py01, inteligencia_artificial). area_de(py01, bases_datos).
area_de(py02, redes).                   area_de(py02, seguridad).
area_de(py03, software).  area_de(py03, educacion).  area_de(py03, multimedia).

% ---------------------------------------------------------------------
% Comisiones
% comision(Id, Nombre, Objetivo, NumeroDeIntegrantes).
% ---------------------------------------------------------------------
comision(com01, 'Comisión de Evaluación Curricular',
         'Revisar y actualizar los planes de estudio', 3).
comision(com02, 'Comisión de Infraestructura Tecnológica',
         'Supervisar laboratorios, equipo y red de la facultad', 2).
comision(com03, 'Comisión de Vinculación y Difusión',
         'Difundir las actividades de la facultad y vincular con el sector productivo', 2).

area_de(com01, educacion).  area_de(com01, software).
area_de(com02, redes).      area_de(com02, seguridad).
area_de(com03, multimedia). area_de(com03, educacion).

% ---------------------------------------------------------------------
% Cursos de capacitación al profesor
% curso_capacitacion(Id, Nombre, Objetivo, Horas, FechaInicio, FechaConclusion).
% ---------------------------------------------------------------------
curso_capacitacion(cap01, 'Python para Ciencia de Datos',
    'Manipular y analizar datos con Python', 40, date(2026, 3, 2), date(2026, 3, 27)).
curso_capacitacion(cap02, 'Aprendizaje Automático Aplicado',
    'Construir y evaluar modelos de aprendizaje automático', 60, date(2026, 11, 9), date(2026, 12, 18)).
curso_capacitacion(cap03, 'Ciberseguridad Defensiva',
    'Aplicar técnicas de defensa y respuesta a incidentes', 40, date(2026, 11, 16), date(2026, 12, 11)).
curso_capacitacion(cap04, 'Metodologías Ágiles',
    'Gestionar proyectos de software con Scrum y Kanban', 30, date(2026, 6, 8), date(2026, 6, 26)).
curso_capacitacion(cap05, 'Diseño Instruccional y Aulas Virtuales',
    'Diseñar cursos en línea centrados en el aprendizaje', 25, date(2027, 1, 11), date(2027, 1, 29)).
curso_capacitacion(cap06, 'Bases de Datos NoSQL',
    'Modelar y administrar bases de datos documentales y de grafos', 30, date(2027, 1, 18), date(2027, 2, 12)).
curso_capacitacion(cap07, 'Producción de Contenido Multimedia',
    'Producir video y recursos interactivos para la docencia', 30, date(2027, 2, 1), date(2027, 2, 26)).
curso_capacitacion(cap08, 'Redes Definidas por Software',
    'Configurar redes programables con SDN', 40, date(2027, 2, 8), date(2027, 3, 12)).

area_de(cap01, inteligencia_artificial). area_de(cap01, bases_datos).
area_de(cap02, inteligencia_artificial).
area_de(cap03, seguridad).               area_de(cap03, redes).
area_de(cap04, software).
area_de(cap05, educacion).
area_de(cap06, bases_datos).
area_de(cap07, multimedia).              area_de(cap07, educacion).
area_de(cap08, redes).

% Cursos de capacitación ya tomados por cada profesor
% capacitacion_tomada(NumEmpleado, IdCapacitacion).
capacitacion_tomada(1001, cap01).
capacitacion_tomada(1002, cap04).
capacitacion_tomada(1003, cap01).
capacitacion_tomada(1004, cap04).
capacitacion_tomada(1006, cap01).
capacitacion_tomada(1007, cap03).
capacitacion_tomada(1008, cap04).
capacitacion_tomada(1008, cap05).

% =====================================================================
% 2. REGLAS: PERFIL DEL PROFESOR
% =====================================================================

valor_grado(licenciatura, 1).
valor_grado(maestria,     2).
valor_grado(doctorado,    3).

valor_estudio(licenciatura, 2).
valor_estudio(maestria,     3).
valor_estudio(doctorado,    4).

umbral(cuerpo,   10).   % puntaje mínimo para entrar a un cuerpo académico
umbral(proyecto,  8).   % puntaje mínimo para ser candidato a un proyecto

% perfil(+Emp, +Area, -Puntos, -Desglose)
% Puntaje del perfil (estudios + capacitación) de un profesor en un área:
%   grado académico (1-3)                       + especialidad igual al área (4)
%   + estudios en el área (lic 2, mae 3, doc 4) + acreditaciones del área (3 c/u)
%   + acreditaciones generales (1 c/u)          + capacitaciones tomadas del área (2 c/u)
%   + cursos que domina del área (1 c/u)
perfil(Emp, Area, P, D) :-
    profesor(Emp, _, Grado, Esp, Domina),
    valor_grado(Grado, PG),
    ( Esp == Area -> PE = 4 ; PE = 0 ),
    aggregate_all(sum(V), (estudio(Emp, N, _, _, Area), valor_estudio(N, V)), PEst),
    aggregate_all(count, acreditacion(Emp, _, _, Area), NA),
    aggregate_all(count, acreditacion(Emp, _, _, general), NG),
    aggregate_all(count, (capacitacion_tomada(Emp, C), area_de(C, Area)), NC),
    aggregate_all(count, (member(Cu, Domina), area_de(Cu, Area)), ND),
    PA is 3*NA + NG, PC is 2*NC,
    P is PG + PE + PEst + PA + PC + ND,
    D = _{grado: PG, especialidad: PE, estudios: PEst,
          acreditaciones: PA, capacitaciones: PC, cursos: ND}.

perfil(Emp, Area, P) :- perfil(Emp, Area, P, _).

% mejor_area(+Emp, +Entidad, -Area, -Puntos)
% De las áreas de una entidad, la que mejor encaja con el profesor.
mejor_area(Emp, Entidad, Area, P) :-
    profesor(Emp, _, _, _, _),
    findall(P0-A0, (area_de(Entidad, A0), perfil(Emp, A0, P0)), L),
    L \= [],
    max_member(P-Area, L).

posgrado(Emp) :- profesor(Emp, _, G, _, _), memberchk(G, [maestria, doctorado]).

% =====================================================================
% 3. REGLAS DE ASIGNACIÓN
% =====================================================================

% ---------- Opción 1: Academias --------------------------------------
% Puntaje = perfil en el área de la academia + 2 por cada materia de la
% academia que el profesor domina. Cada profesor queda en UNA academia:
% el líder en la suya; los demás en la de mayor puntaje.
puntaje_academia(Emp, Acad, P, NDom) :-
    academia(Acad, _, Materias, _),
    profesor(Emp, _, _, _, Domina),
    mejor_area(Emp, Acad, _, PA),
    aggregate_all(count, (member(M, Materias), memberchk(M, Domina)), NDom),
    P is PA + 2*NDom.

academia_asignada(Emp, Acad, Motivo) :-
    profesor(Emp, _, _, _, _),
    (   academia(A0, _, _, Emp)
    ->  A = A0, M = lider
    ;   findall(P-A1, puntaje_academia(Emp, A1, P, _), L),
        max_member(_-A, L), M = perfil
    ),
    Acad = A, Motivo = M.

ranking_academia(Acad, Ranking) :-          % [Puntaje-(Emp-MateriasDominadas)]
    findall(P-(E-N), puntaje_academia(E, Acad, P, N), L),
    sort(1, @>=, L, Ranking).

% ---------- Opción 2: Cuerpos académicos -----------------------------
% Requisitos: posgrado (maestría o doctorado) y puntaje >= umbral.
% Cada profesor pertenece a UN cuerpo académico (el de mayor puntaje).
puntaje_ca(Emp, CA, P) :-
    cuerpo_academico(CA, _, _, _, _),
    mejor_area(Emp, CA, _, P).

elegible_ca(Emp, CA, P) :-
    posgrado(Emp), umbral(cuerpo, U),
    puntaje_ca(Emp, CA, P), P >= U.

ca_asignado(Emp, CA, Motivo) :-
    profesor(Emp, _, _, _, _),
    (   cuerpo_academico(C0, _, _, Emp, _)
    ->  C = C0, M = lider
    ;   findall(P-C1, elegible_ca(Emp, C1, P), L), L \= [],
        max_member(_-C, L), M = perfil
    ),
    CA = C, Motivo = M.

ranking_ca(CA, Ranking) :-                   % [Puntaje-Emp]
    findall(P-E, puntaje_ca(E, CA, P), L),
    sort(1, @>=, L, Ranking).

% ---------- Opción 3: Proyectos --------------------------------------
% Candidatos: no son líder ni integrantes y su puntaje >= umbral.
% Se recomiendan los mejores hasta completar el cupo del proyecto.
candidatos_proyecto(Py, Cands) :-            % [Puntaje-Emp]
    proyecto(Py, _, _, _, Lider, Integrantes, _, _),
    umbral(proyecto, U),
    findall(P-E,
            ( profesor(E, _, _, _, _), E \== Lider,
              \+ memberchk(E, Integrantes),
              mejor_area(E, Py, _, P), P >= U ),
            L),
    sort(1, @>=, L, Cands).

recomendados_proyecto(Py, Recs) :-
    proyecto(Py, _, _, _, _, Integrantes, _, _),
    proyecto_cupo(Py, Cupo),
    length(Integrantes, N),
    Libres is max(0, Cupo - N),
    candidatos_proyecto(Py, Cands),
    tomar(Libres, Cands, Recs).

% ---------- Opción 4: Mejor profesor para un curso -------------------
% Solo profesores que dominan el curso. Puntaje = perfil en el área del
% curso + bono por la posición del curso en su lista (1º=10, 2º=8, ...).
puntaje_curso(Emp, Curso, P, Pos) :-
    curso(Curso, _, _, _, _),
    profesor(Emp, _, _, _, Domina),
    nth1(Pos, Domina, Curso),
    mejor_area(Emp, Curso, _, PA),
    Bono is max(2, 12 - 2*Pos),
    P is PA + Bono.

ranking_curso(Curso, Ranking) :-             % [Puntaje-(Emp-Posicion)]
    findall(P-(E-Pos), puntaje_curso(E, Curso, P, Pos), L),
    sort(1, @>=, L, Ranking).

mejor_profesor_curso(Curso, Emp, P, Pos) :-
    ranking_curso(Curso, [P-(Emp-Pos)|_]).

% ---------- Opción 5: Cursos de capacitación -------------------------
% Se asigna a quien NO lo ha tomado y cuyo perfil está relacionado con el
% área del curso (por su especialidad o por los cursos que imparte).
relacionado_capacitacion(Emp, Cap) :-
    once(( area_de(Cap, A),
           profesor(Emp, _, _, Esp, Domina),
           ( Esp == A ; member(C, Domina), area_de(C, A) ) )).

candidatos_capacitacion(Cap, Cands) :-       % [Afinidad-Emp]
    curso_capacitacion(Cap, _, _, _, _, _),
    findall(P-E,
            ( profesor(E, _, _, _, _),
              \+ capacitacion_tomada(E, Cap),
              relacionado_capacitacion(E, Cap),
              mejor_area(E, Cap, _, P) ),
            L),
    sort(1, @>=, L, Cands).

% ---------- Extra: Comisiones ----------------------------------------
integrantes_comision(Com, Integrantes) :-    % [Puntaje-Emp]
    comision(Com, _, _, Cupo),
    findall(P-E, (profesor(E, _, _, _, _), mejor_area(E, Com, _, P)), L0),
    sort(1, @>=, L0, L),
    tomar(Cupo, L, Integrantes).

% ---------- Opción 6: Buscar un profesor -----------------------------
% Por número de empleado o por nombre (sin importar mayúsculas ni acentos).
buscar_profesor(Texto, [E]) :-
    atom_number(Texto, E), integer(E), profesor(E, _, _, _, _), !.
buscar_profesor(Texto, Emps) :-
    Texto \== '',
    normalizar(Texto, T),
    findall(E, ( profesor(E, Nom, _, _, _),
                 normalizar(Nom, N), sub_atom(N, _, _, _, T) ), Emps), !.
buscar_profesor(_, []).

rol_proyecto(E, P, lider)       :- proyecto(P, _, _, _, E, _, _, _).
rol_proyecto(E, P, integrante)  :- proyecto(P, _, _, _, _, I, _, _), memberchk(E, I).
rol_proyecto(E, P, recomendado) :- proyecto(P, _, _, _, _, _, _, _),
                                   recomendados_proyecto(P, R), memberchk(_-E, R).

% =====================================================================
% 3b. ASIGNACIONES REGISTRADAS POR EL USUARIO
% ---------------------------------------------------------------------
% asignado(Tipo, Entidad, NumEmpleado)
%   Tipo: academia, cuerpo, proyecto, curso, capacitacion, comision.
% Las reglas de la sección 3 RECOMIENDAN; aquí el usuario ASIGNA (o
% aplica la recomendación) y el sistema VALIDA el perfil antes de aceptar.
% Se guardan en asignaciones_guardadas.pl, en la misma carpeta.
% =====================================================================
:- dynamic asignado/3.
:- dynamic archivo_asignaciones/1.

:- prolog_load_context(directory, D),
   atomic_list_concat([D, '/asignaciones_guardadas.pl'], F),
   retractall(archivo_asignaciones(_)),
   assertz(archivo_asignaciones(F)).

cargar_asignaciones :-
    retractall(asignado(_, _, _)),
    archivo_asignaciones(F),
    (   exists_file(F)
    ->  catch(setup_call_cleanup(open(F, read, S, [encoding(utf8)]),
                                 leer_asignaciones(S),
                                 close(S)),
              _, true)
    ;   true
    ).

leer_asignaciones(S) :-
    read_term(S, T, []),
    (   T == end_of_file
    ->  true
    ;   ( T = asignado(Ti, En, Em) -> assertz(asignado(Ti, En, Em)) ; true ),
        leer_asignaciones(S)
    ).

guardar_asignaciones :-
    archivo_asignaciones(F),
    catch(setup_call_cleanup(
              open(F, write, S, [encoding(utf8)]),
              ( format(S, "% Asignaciones registradas desde la interfaz (archivo generado).~n", []),
                forall(asignado(T, E, P), portray_clause(S, asignado(T, E, P))) ),
              close(S)),
          Error, print_message(warning, Error)).

:- initialization(cargar_asignaciones).

tipos([academia, cuerpo, proyecto, curso, capacitacion, comision]).

entidad(academia, Id, N)     :- academia(Id, N, _, _).
entidad(cuerpo, Id, N)       :- cuerpo_academico(Id, N, _, _, _).
entidad(proyecto, Id, N)     :- proyecto(Id, N, _, _, _, _, _, _).
entidad(curso, Id, N)        :- curso(Id, _, N, _, _).
entidad(capacitacion, Id, N) :- curso_capacitacion(Id, N, _, _, _, _).
entidad(comision, Id, N)     :- comision(Id, N, _, _).

tipo_texto(academia,     'Academia').
tipo_texto(cuerpo,       'Cuerpo académico').
tipo_texto(proyecto,     'Proyecto').
tipo_texto(curso,        'Curso a impartir').
tipo_texto(capacitacion, 'Curso de capacitación').
tipo_texto(comision,     'Comisión').

tipo_plural(academia,     'Academias').
tipo_plural(cuerpo,       'Cuerpos académicos').
tipo_plural(proyecto,     'Proyectos').
tipo_plural(curso,        'Cursos a impartir').
tipo_plural(capacitacion, 'Cursos de capacitación').
tipo_plural(comision,     'Comisiones').

ruta_tipo(academia,     '/html/academias').
ruta_tipo(cuerpo,       '/html/cuerpos').
ruta_tipo(proyecto,     '/html/proyectos').
ruta_tipo(curso,        '/html/cursos').
ruta_tipo(capacitacion, '/html/capacitacion').
ruta_tipo(comision,     '/html/comisiones').

% Asignaciones fijas: líderes e integrantes originales (no se pueden quitar)
fijo(academia, A, E) :- academia(A, _, _, E).
fijo(cuerpo, C, E)   :- cuerpo_academico(C, _, _, E, _).
fijo(proyecto, P, E) :- proyecto(P, _, _, _, E, _, _, _).
fijo(proyecto, P, E) :- proyecto(P, _, _, _, _, I, _, _), member(E, I).

miembro(T, X, E) :- fijo(T, X, E).
miembro(T, X, E) :- asignado(T, X, E).

% validar(+Tipo, +Entidad, +Emp, -Resultado)   Resultado = ok ; no(Motivo)
validar(Tipo, Ent, E, Res) :-
    (   miembro(Tipo, Ent, E)
    ->  Res = no('Ya está asignado aquí.')
    ;   once(no_cumple(Tipo, Ent, E, R))
    ->  Res = no(R)
    ;   Res = ok
    ).

% no_cumple(+Tipo, +Entidad, +Emp, -Motivo): requisito de perfil que falla
no_cumple(academia, A, E, R) :-
    miembro(academia, A2, E), A2 \== A, academia(A2, N2, _, _),
    format(atom(R), 'Ya pertenece a la ~w (cada profesor pertenece a una sola academia).', [N2]).
no_cumple(academia, A, E, 'Su perfil no corresponde: no domina materias de la academia y su especialidad no es del área.') :-
    academia(A, _, Mat, _), profesor(E, _, _, Esp, Dom),
    \+ ( member(M, Mat), memberchk(M, Dom) ),
    \+ area_de(A, Esp).
no_cumple(cuerpo, _, E, 'Requiere posgrado (maestría o doctorado).') :-
    \+ posgrado(E).
no_cumple(cuerpo, C, E, R) :-
    umbral(cuerpo, U), puntaje_ca(E, C, P), P < U,
    format(atom(R), 'Su puntaje de perfil (~w) es menor al mínimo (~w).', [P, U]).
no_cumple(cuerpo, C, E, R) :-
    miembro(cuerpo, C2, E), C2 \== C, cuerpo_academico(C2, N2, _, _, _),
    format(atom(R), 'Ya pertenece al cuerpo académico ~w (solo puede pertenecer a uno).', [N2]).
no_cumple(proyecto, Py, E, R) :-
    umbral(proyecto, U), mejor_area(E, Py, _, P), P < U,
    format(atom(R), 'Su puntaje de perfil (~w) es menor al mínimo (~w).', [P, U]).
no_cumple(proyecto, Py, _, R) :-
    proyecto_lleno(Py, Cupo),
    format(atom(R), 'El proyecto ya completó su cupo de ~w integrantes.', [Cupo]).
no_cumple(curso, C, E, 'No domina este curso (no está en su lista de cursos).') :-
    profesor(E, _, _, _, Dom), \+ memberchk(C, Dom).
no_cumple(curso, C, E, R) :-
    asignado(curso, C, E2), E2 \== E, nombre_prof(E2, N2),
    format(atom(R), 'El curso ya tiene asignado a ~w. Quítalo primero.', [N2]).
no_cumple(capacitacion, C, E, 'Ya tomó este curso de capacitación.') :-
    capacitacion_tomada(E, C).
no_cumple(capacitacion, C, E, 'El curso no se relaciona con su perfil (especialidad o cursos que imparte).') :-
    \+ relacionado_capacitacion(E, C).
no_cumple(comision, Com, _, R) :-
    comision(Com, _, _, Cupo),
    aggregate_all(count, asignado(comision, Com, _), N), N >= Cupo,
    format(atom(R), 'La comisión ya tiene sus ~w integrantes.', [Cupo]).

proyecto_lleno(Py, Cupo) :-
    proyecto(Py, _, _, _, _, Int, _, _), proyecto_cupo(Py, Cupo),
    length(Int, N0),
    aggregate_all(count, asignado(proyecto, Py, _), N1),
    N0 + N1 >= Cupo.

% Recomendación del sistema (reglas de la sección 3)
recomendado(academia, A, E)     :- academia_asignada(E, A, perfil).
recomendado(cuerpo, C, E)       :- ca_asignado(E, C, perfil).
recomendado(proyecto, P, E)     :- recomendados_proyecto(P, R), member(_-E, R).
recomendado(curso, C, E)        :- mejor_profesor_curso(C, E, _, _).
recomendado(capacitacion, C, E) :- candidatos_capacitacion(C, L), member(_-E, L).
recomendado(comision, C, E)     :- integrantes_comision(C, L), member(_-E, L).

% Recomendados que todavía no están asignados
pendientes(Tipo, Ent, Es) :-
    findall(E, (recomendado(Tipo, Ent, E), \+ miembro(Tipo, Ent, E)), Es0),
    list_to_set(Es0, Es).

% Asigna a los recomendados que cumplen; regresa asignados y rechazados
aplicar_recomendacion(Tipo, Ent, Asignados, Rechazados) :-
    pendientes(Tipo, Ent, Es),
    aplicar_lista(Es, Tipo, Ent, Asignados, Rechazados),
    guardar_asignaciones.

aplicar_lista([], _, _, [], []).
aplicar_lista([E|Es], T, X, As, Rs) :-
    validar(T, X, E, Res),
    (   Res == ok
    ->  assertz(asignado(T, X, E)), As = [E|As1], Rs = Rs1
    ;   As = As1, Rs = [E|Rs1]
    ),
    aplicar_lista(Es, T, X, As1, Rs1).

% =====================================================================
% 4. UTILIDADES
% =====================================================================
tomar(0, _, []) :- !.
tomar(_, [], []) :- !.
tomar(N, [X|Xs], [X|Ys]) :- N1 is N - 1, tomar(N1, Xs, Ys).

normalizar(Texto, Norm) :-
    downcase_atom(Texto, Min),
    atom_codes(Min, Cs),
    maplist(sin_acento, Cs, Cs2),
    atom_codes(Norm, Cs2).

sin_acento(C, S) :- ( acento(C, S0) -> S = S0 ; S = C ).
acento(0'á, 0'a). acento(0'é, 0'e). acento(0'í, 0'i).
acento(0'ó, 0'o). acento(0'ú, 0'u). acento(0'ü, 0'u).

nombre_prof(E, N) :- profesor(E, N, _, _, _).

fecha_iso(date(Y, M, D), A) :- format(atom(A), '~d-~|~`0t~d~2+-~|~`0t~d~2+', [Y, M, D]).
fecha_texto(date(Y, M, D), A) :- format(atom(A), '~|~`0t~d~2+/~|~`0t~d~2+/~d', [D, M, Y]).

grado_texto(licenciatura, 'Licenciatura').
grado_texto(maestria,     'Maestría').
grado_texto(doctorado,    'Doctorado').

estatus_texto(en_formacion,     'En formación').
estatus_texto(en_consolidacion, 'En consolidación').
estatus_texto(consolidado,      'Consolidado').

motivo_texto(lider,  'Líder (asignación fija)').
motivo_texto(perfil, 'Recomendado por perfil').

rol_texto(lider,       'Líder').
rol_texto(integrante,  'Integrante').
rol_texto(recomendado, 'Recomendado por el sistema').

area_texto(A, T) :- ( area(A, T0) -> T = T0 ; T = A ).

areas_texto(Entidad, T) :-
    findall(N, (area_de(Entidad, A), area(A, N)), Ns),
    atomic_list_concat(Ns, ', ', T).

lista_nombres([], '—') :- !.
lista_nombres(Emps, T) :- maplist(nombre_prof, Emps, Ns), atomic_list_concat(Ns, ', ', T).

nombres_cursos(Ids, T) :-
    findall(N, (member(I, Ids), curso(I, _, N, _, _)), Ns),
    atomic_list_concat(Ns, ', ', T).

% =====================================================================
% 5. SERVIDOR
% =====================================================================
:- use_module(library(http/http_server)).
:- use_module(library(http/http_dispatch)).
:- if(exists_source(library(json))).
:- use_module(library(json)).
:- else.
:- use_module(library(http/json)).          % versiones anteriores de SWI-Prolog
:- endif.
:- use_module(library(http/http_json)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/html_write)).

:- initialization http_server([port(8080)]).

% Vistas HTML
:- http_handler(root(.),                html_inicio,        []).
:- http_handler(root(home),             html_inicio,        []).
:- http_handler(root(html/profesores),  html_profesores,    []).
:- http_handler(root(html/academias),   html_academias,     []).
:- http_handler(root(html/cuerpos),     html_cuerpos,       []).
:- http_handler(root(html/proyectos),   html_proyectos,     []).
:- http_handler(root(html/cursos),      html_cursos,        []).
:- http_handler(root(html/capacitacion),html_capacitacion,  []).
:- http_handler(root(html/comisiones),  html_comisiones,    []).
:- http_handler(root(html/buscar),      html_buscar,        []).
:- http_handler(root(html/registro),    html_registro,      []).
% Acciones de la interfaz (formularios POST)
:- http_handler(root(html/asignar),     html_asignar,       []).
:- http_handler(root(html/quitar),      html_quitar,        []).
:- http_handler(root(html/aplicar),     html_aplicar,       []).
:- http_handler(root(html/reiniciar),   html_reiniciar,     []).
% API REST (JSON)
:- http_handler(root(api/profesores),             api_profesores,     []).
:- http_handler(root(api/asignar/academias),      api_academias,      []).
:- http_handler(root(api/asignar/cuerpos),        api_cuerpos,        []).
:- http_handler(root(api/asignar/proyectos),      api_proyectos,      []).
:- http_handler(root(api/asignar/cursos),         api_cursos,         []).
:- http_handler(root(api/asignar/capacitaciones), api_capacitaciones, []).
:- http_handler(root(api/asignar/comisiones),     api_comisiones,     []).
:- http_handler(root(api/profesor),               api_profesor,       []).

% =====================================================================
% 6. API REST (JSON)
% =====================================================================

% GET /api/profesores
api_profesores(_Request) :-
    findall(_{empleado: E, nombre: N, grado: G, especialidad: Es, cursos_domina: Ds},
            profesor(E, N, G, Es, Ds), L),
    reply_json_dict(L).

% GET /api/asignar/academias            -> academia asignada a cada profesor
% GET /api/asignar/academias?id=ac_sw   -> ranking de una academia
api_academias(Request) :-
    http_parameters(Request, [id(Id, [optional(true)])]),
    (   var(Id)
    ->  findall(_{empleado: E, nombre: N, academia: A, academia_nombre: AN, motivo: M},
                ( academia_asignada(E, A, M), nombre_prof(E, N), academia(A, AN, _, _) ), L),
        reply_json_dict(_{asignaciones: L})
    ;   academia(Id, Nom, Mat, Lid)
    ->  ranking_academia(Id, R),
        findall(_{empleado: E, nombre: N, puntaje: P, materias_que_domina: ND, asignado: As},
                ( member(P-(E-ND), R), nombre_prof(E, N),
                  ( academia_asignada(E, Id, _) -> As = true ; As = false ) ), Rk),
        findall(E, academia_asignada(E, Id, _), Asig),
        reply_json_dict(_{academia: Id, nombre: Nom, materias: Mat, lider: Lid,
                          asignados: Asig, ranking: Rk})
    ;   reply_json_dict(_{error: 'Academia no encontrada'}, [status(404)])
    ).

% GET /api/asignar/cuerpos[?id=ca01]
api_cuerpos(Request) :-
    http_parameters(Request, [id(Id, [optional(true)])]),
    (   var(Id)
    ->  findall(_{id: C, nombre: CN, lider: Lid, estatus: Est, integrantes: Ints},
                ( cuerpo_academico(C, CN, _, Lid, Est),
                  findall(_{empleado: E, nombre: N, motivo: M},
                          (ca_asignado(E, C, M), nombre_prof(E, N)), Ints) ), L),
        reply_json_dict(_{cuerpos_academicos: L})
    ;   cuerpo_academico(Id, Nom, Linea, Lid, Est)
    ->  ranking_ca(Id, R),
        findall(_{empleado: E, nombre: N, puntaje: P, elegible: El, asignado: As},
                ( member(P-E, R), nombre_prof(E, N),
                  ( elegible_ca(E, Id, _) -> El = true ; El = false ),
                  ( ca_asignado(E, Id, _) -> As = true ; As = false ) ), Rk),
        reply_json_dict(_{id: Id, nombre: Nom, linea_investigacion: Linea, lider: Lid,
                          estatus: Est, ranking: Rk})
    ;   reply_json_dict(_{error: 'Cuerpo académico no encontrado'}, [status(404)])
    ).

% GET /api/asignar/proyectos[?id=py01]
api_proyectos(Request) :-
    http_parameters(Request, [id(Id, [optional(true)])]),
    (   var(Id)
    ->  findall(D, (proyecto(P, _, _, _, _, _, _, _), proyecto_json(P, D)), L),
        reply_json_dict(_{proyectos: L})
    ;   proyecto_json(Id, D)
    ->  reply_json_dict(D)
    ;   reply_json_dict(_{error: 'Proyecto no encontrado'}, [status(404)])
    ).

proyecto_json(Py, D) :-
    proyecto(Py, Nom, Obj, Ent, Lid, Int, FI, FE),
    proyecto_cupo(Py, Cupo),
    fecha_iso(FI, FIi), fecha_iso(FE, FEi),
    recomendados_proyecto(Py, Recs),
    findall(_{empleado: E, nombre: N, puntaje: P}, (member(P-E, Recs), nombre_prof(E, N)), RecsJ),
    D = _{id: Py, nombre: Nom, objetivo: Obj, entregables: Ent, lider: Lid,
          integrantes: Int, cupo: Cupo, fecha_inicio: FIi, fecha_entrega: FEi,
          recomendados: RecsJ}.

% GET /api/asignar/cursos            -> mejor profesor de cada curso
% GET /api/asignar/cursos?id=bd101   -> mejor profesor + ranking de un curso
api_cursos(Request) :-
    http_parameters(Request, [id(Id, [optional(true)])]),
    (   var(Id)
    ->  findall(_{curso: C, nombre: CN, mejor_profesor: M},
                ( curso(C, _, CN, _, _),
                  ( mejor_profesor_curso(C, E, P, _)
                  -> nombre_prof(E, N), M = _{empleado: E, nombre: N, puntaje: P}
                  ;  M = null ) ), L),
        reply_json_dict(_{asignaciones: L})
    ;   curso(Id, Cr, Nom, Obj, Ac)
    ->  ranking_curso(Id, R),
        findall(_{empleado: E, nombre: N, puntaje: P, posicion_en_su_lista: Pos},
                (member(P-(E-Pos), R), nombre_prof(E, N)), Rk),
        ( Rk = [Mejor|_] -> true ; Mejor = null ),
        reply_json_dict(_{curso: Id, nombre: Nom, creditos: Cr, objetivo: Obj, academia: Ac,
                          mejor_profesor: Mejor, ranking: Rk})
    ;   reply_json_dict(_{error: 'Curso no encontrado'}, [status(404)])
    ).

% GET /api/asignar/capacitaciones[?id=cap02]
api_capacitaciones(Request) :-
    http_parameters(Request, [id(Id, [optional(true)])]),
    (   var(Id)
    ->  findall(D, (curso_capacitacion(C, _, _, _, _, _), capacitacion_json(C, D)), L),
        reply_json_dict(_{capacitaciones: L})
    ;   capacitacion_json(Id, D)
    ->  reply_json_dict(D)
    ;   reply_json_dict(_{error: 'Curso de capacitación no encontrado'}, [status(404)])
    ).

capacitacion_json(C, D) :-
    curso_capacitacion(C, Nom, Obj, H, FI, FC),
    fecha_iso(FI, FIi), fecha_iso(FC, FCi),
    findall(E, capacitacion_tomada(E, C), Ya),
    candidatos_capacitacion(C, Cands),
    findall(_{empleado: E, nombre: N, afinidad: P}, (member(P-E, Cands), nombre_prof(E, N)), CandsJ),
    D = _{id: C, nombre: Nom, objetivo: Obj, horas: H, fecha_inicio: FIi,
          fecha_conclusion: FCi, ya_lo_tomaron: Ya, asignados: CandsJ}.

% GET /api/asignar/comisiones
api_comisiones(_Request) :-
    findall(_{id: C, nombre: CN, integrantes: Ints},
            ( comision(C, CN, _, _), integrantes_comision(C, L),
              findall(_{empleado: E, nombre: N, puntaje: P}, (member(P-E, L), nombre_prof(E, N)), Ints) ),
            Res),
    reply_json_dict(_{comisiones: Res}).

% GET /api/profesor?empleado=1001   o   /api/profesor?nombre=maria
api_profesor(Request) :-
    http_parameters(Request, [ empleado(Emp, [optional(true)]),
                               nombre(Nom, [optional(true)]) ]),
    (   nonvar(Emp) -> Texto = Emp
    ;   nonvar(Nom) -> Texto = Nom
    ;   Texto = ''
    ),
    buscar_profesor(Texto, Emps),
    (   Emps == []
    ->  reply_json_dict(_{error: 'Profesor no encontrado'}, [status(404)])
    ;   maplist(info_profesor, Emps, Infos),
        reply_json_dict(_{resultados: Infos})
    ).

info_profesor(E, Info) :-
    profesor(E, N, G, Es, Dom),
    findall(_{curso: C, nombre: CN}, (member(C, Dom), curso(C, _, CN, _, _)), Cursos),
    findall(_{nivel: Ni, titulo: T, institucion: I, area: Ar}, estudio(E, Ni, T, I, Ar), Est),
    findall(_{nombre: AN, organismo: O, area: Ar}, acreditacion(E, AN, O, Ar), Acr),
    findall(_{id: C, nombre: CN, horas: H},
            (capacitacion_tomada(E, C), curso_capacitacion(C, CN, _, H, _, _)), Caps),
    asignaciones_json(E, Asig),
    Info = _{empleado: E, nombre: N, grado: G, especialidad: Es,
             cursos_domina: Cursos, estudios: Est, acreditaciones: Acr,
             capacitaciones_tomadas: Caps, asignaciones: Asig}.

asignaciones_json(E, A) :-
    (   academia_asignada(E, Ac, M1)
    ->  academia(Ac, AcN, _, _), Acad = _{id: Ac, nombre: AcN, motivo: M1}
    ;   Acad = null ),
    (   ca_asignado(E, Ca, M2)
    ->  cuerpo_academico(Ca, CaN, _, _, _), CA = _{id: Ca, nombre: CaN, motivo: M2}
    ;   CA = null ),
    findall(_{id: P, nombre: PN, rol: Rol},
            (rol_proyecto(E, P, Rol), proyecto(P, PN, _, _, _, _, _, _)), Proys),
    findall(_{id: C, nombre: CN, puntaje: Pt},
            (curso(C, _, CN, _, _), mejor_profesor_curso(C, E, Pt, _)), Cursos),
    findall(_{id: C, nombre: CN},
            ( curso_capacitacion(C, CN, _, _, _, _),
              candidatos_capacitacion(C, L), memberchk(_-E, L) ), Caps),
    findall(_{id: C, nombre: CN},
            ( comision(C, CN, _, _), integrantes_comision(C, L2), memberchk(_-E, L2) ), Coms),
    A = _{academia: Acad, cuerpo_academico: CA, proyectos: Proys,
          cursos_a_impartir: Cursos, capacitaciones_asignadas: Caps, comisiones: Coms}.

% =====================================================================
% 7. VISTAS HTML
% =====================================================================

estilo('body{font-family:system-ui,Segoe UI,Arial,sans-serif;max-width:1050px;margin:0 auto;padding:16px;color:#1f2933;background:#f5f7fa}
nav{background:#14365d;padding:10px 14px;border-radius:8px;margin-bottom:16px}
nav a{color:#fff;text-decoration:none;margin-right:14px;font-size:.95em}
nav a:hover{text-decoration:underline}
h1{color:#14365d;font-size:1.6em}
h2{color:#1d4f86;font-size:1.25em;margin-top:0}
.tarjeta{background:#fff;border:1px solid #dde3ea;border-radius:8px;padding:14px 18px;margin:14px 0}
table{border-collapse:collapse;width:100%;margin:8px 0;background:#fff}
th,td{border:1px solid #dde3ea;padding:6px 8px;text-align:left;vertical-align:top}
th{background:#e8eef6}
.nota{color:#52606d;font-size:.9em}
.destacado{background:#e6f4ea;border-left:4px solid #2e7d32;padding:8px 12px}
input{padding:6px 8px;font-size:1em}
code{background:#eef1f5;padding:1px 4px;border-radius:4px}
.selector{display:flex;flex-wrap:wrap;gap:10px;align-items:center;background:#fff;border:1px solid #dde3ea;border-radius:8px;padding:12px 16px;margin:14px 0}
select{padding:7px 8px;font-size:1em;max-width:100%;border:1px solid #b9c4d0;border-radius:6px}
input[type=submit]{background:#14365d;color:#fff;border:0;border-radius:6px;padding:8px 18px;font-size:1em;cursor:pointer}
input[type=submit]:hover{background:#1d4f86}
.instruccion{background:#fff8e1;border-left:4px solid #f0a500;padding:10px 12px}
.en_linea{display:inline-block;margin:0}
.en_linea input[type=submit]{padding:4px 12px;font-size:.9em}
input.quitar{background:#b3261e}
input.quitar:hover{background:#8c1d18}
input.aplicar{background:#2e7d32}
input.aplicar:hover{background:#1f5c23}
.panel{display:flex;flex-direction:column;gap:8px;margin:10px 0}
.panel p{margin:0}
.recomendacion{background:#eef4fb;border-left:4px solid #1d4f86;padding:8px 12px}
.msg_ok,.msg_err{padding:10px 14px;border-radius:8px;margin:12px 0;font-weight:600}
.msg_ok{background:#e6f4ea;border:1px solid #2e7d32;color:#1f5c23}
.msg_err{background:#fdecea;border:1px solid #b3261e;color:#8c1d18}
.no{color:#8c1d18;font-size:.85em}
.fijo{color:#52606d;font-style:italic}
.si{color:#2e7d32;font-weight:600;margin-right:6px}
ul.registradas li{margin:4px 0}').

pagina(Titulo, Cuerpo) :-
    estilo(Css),
    reply_html_page(
        [title(Titulo), meta([name(viewport), content('width=device-width, initial-scale=1')]), style(Css)],
        [\menu, h1(Titulo) | Cuerpo]).

menu -->
    html(nav([ a(href('/home'), 'Inicio'),
               a(href('/html/academias'), '1. Academias'),
               a(href('/html/cuerpos'), '2. Cuerpos académicos'),
               a(href('/html/proyectos'), '3. Proyectos'),
               a(href('/html/cursos'), '4. Cursos'),
               a(href('/html/capacitacion'), '5. Capacitación'),
               a(href('/html/buscar'), '6. Buscar profesor'),
               a(href('/html/comisiones'), 'Comisiones'),
               a(href('/html/profesores'), 'Profesores'),
               a(href('/html/registro'), 'Registro de asignaciones') ])).

% Tabla genérica: encabezados y filas (cada fila es una lista de celdas)
tabla(_, []) --> !, html(p(class(nota), 'Sin registros.')).
tabla(Enc, Filas) -->
    { maplist([E, th(E)]>>true, Enc, Ths) },
    html(table([tr(Ths), \filas(Filas)])).

filas([]) --> [].
filas([F|Fs]) -->
    { maplist([C, td(C)]>>true, F, Tds) },
    html(tr(Tds)),
    filas(Fs).

liga_prof(E) -->
    { nombre_prof(E, N), format(atom(H), '/html/buscar?q=~w', [E]) },
    html(a(href(H), N)).

% ---------- Interfaz de selección (opciones 1 a 5) -------------------
% pagina_opcion(+Request, +Titulo, +Nota, +Ruta, +Etiqueta, +Pares, +Bloque)
% Muestra una lista desplegable con las entidades (Pares = [Id-Nombre]) y
% un botón "Asignar". Al enviarlo se muestra el resultado de la asignación
% de la entidad elegida, generado por la regla DCG Bloque(Id).
pagina_opcion(Request, Titulo, Nota, Ruta, Etiqueta, Pares, Bloque) :-
    http_parameters(Request, [id(Id, [optional(true), default('')])]),
    resultado_opcion(Id, Pares, Bloque, Resultado),
    pagina(Titulo, [ \mensaje(Request),
                     p(class(nota), Nota),
                     \selector(Ruta, Etiqueta, Pares, Id)
                   | Resultado ]).

% Mensaje de éxito o error después de asignar / quitar
mensaje(Request) -->
    { http_parameters(Request, [ ok(Ok, [optional(true)]),
                                 err(Err, [optional(true)]) ]) },
    (   { nonvar(Ok) }  -> html(div(class(msg_ok), ['✔ ', Ok]))
    ;   { nonvar(Err) } -> html(div(class(msg_err), ['✖ ', Err]))
    ;   []
    ).

% Botón que envía un formulario POST con campos ocultos
boton(Accion, Campos, Texto, Clase) -->
    { findall(input([type(hidden), name(N), value(V)]), member(N=V, Campos), Hs),
      append(Hs, [input([type(submit), value(Texto), class(Clase)])], Contenido) },
    html(form([action(Accion), method(post), class(en_linea)], Contenido)).

% Celda "Acción" de las tablas: Asignar / Quitar / Fijo / No cumple
accion(Tipo, Ent, E) -->
    (   { fijo(Tipo, Ent, E) }
    ->  html(span(class(fijo), 'Fijo (líder o integrante original)'))
    ;   { asignado(Tipo, Ent, E) }
    ->  html(span(class(si), 'Asignado')),
        boton('/html/quitar', [tipo=Tipo, id=Ent, emp=E], 'Quitar', quitar)
    ;   { validar(Tipo, Ent, E, Res) },
        (   { Res == ok }
        ->  boton('/html/asignar', [tipo=Tipo, id=Ent, emp=E], 'Asignar', asignar)
        ;   { Res = no(R) },
            html(span(class(no), ['No cumple: ', R]))
        )
    ).

% Asignados actuales + recomendación del sistema + botón para aplicarla
panel_asignacion(Tipo, Ent) -->
    { findall(E, miembro(Tipo, Ent, E), Ms0), list_to_set(Ms0, Ms),
      lista_nombres(Ms, MsT),
      pendientes(Tipo, Ent, Ps),
      (   Ps == []
      ->  PsT = 'Sin pendientes (ya se aplicó o no hay más candidatos).'
      ;   lista_nombres(Ps, PsT)
      ) },
    html(div(class(panel), [
        p(class(destacado), [b('Asignados: '), MsT]),
        p(class(recomendacion), [b('Recomendación del sistema: '), PsT]),
        \boton_aplicar(Tipo, Ent, Ps) ])).

boton_aplicar(_, _, []) --> !, [].
boton_aplicar(T, X, _) -->
    html(div(\boton('/html/aplicar', [tipo=T, id=X], 'Aplicar recomendación', aplicar))).

resultado_opcion('', _, _, [p(class(instruccion),
        'Selecciona una opción de la lista y presiona «Asignar» para ver a qué profesores asigna el sistema.')]) :- !.
resultado_opcion(todas, _, bloque_curso, [\resumen_cursos]) :- !.
resultado_opcion(todas, Pares, Bloque, Bloques) :- !,
    findall(\G, (member(I-_, Pares), G =.. [Bloque, I]), Bloques).
resultado_opcion(Id, Pares, Bloque, [\G]) :-
    memberchk(Id-_, Pares), !,
    G =.. [Bloque, Id].
resultado_opcion(_, _, _, [p(class(destacado), 'Opción no encontrada.')]).

selector(Ruta, Etiqueta, Pares, Sel) -->
    { findall(option(Attrs, N),
              ( member(I-N, Pares),
                ( I == Sel -> Attrs = [value(I), selected(selected)] ; Attrs = [value(I)] ) ),
              Ops),
      ( Sel == ''    -> A0 = [value(''), disabled(disabled), selected(selected)]
                      ; A0 = [value(''), disabled(disabled)] ),
      ( Sel == todas -> AT = [value(todas), selected(selected)] ; AT = [value(todas)] ),
      append([option(A0, '— Selecciona —') | Ops], [option(AT, 'Ver todas')], Opciones) },
    html(form([action(Ruta), method(get), class(selector)],
              [ label([for(id)], b(Etiqueta)),
                select([name(id), id(id), required(required)], Opciones),
                input([type(submit), value('Asignar')]) ])).

% ---------- Inicio ---------------------------------------------------
html_inicio(Request) :-
    aggregate_all(count, asignado(_, _, _), NAsig),
    pagina('Asignación de profesores · FCI UNACAR', [
        \mensaje(Request),
        p('Sistema basado en conocimiento que asigna profesores de la Facultad de Ciencias de la Información de acuerdo con su perfil de estudios y capacitación.'),
        div(class(tarjeta), [
            h2('¿Cómo asignar a un profesor?'),
            ol([ li(['Entra a una opción (1 a 5), elige la academia, proyecto, curso, etc. y presiona ', b('Asignar'), '.']),
                 li(['En la tabla, presiona ', b('Asignar'), ' junto al profesor que quieras. Si no cumple con el perfil, el sistema te dice por qué.']),
                 li(['O presiona ', b('Aplicar recomendación'), ' para que el sistema asigne a los profesores que recomienda.']),
                 li(['También puedes buscar a un profesor (opción 6) y asignarlo desde su ficha con ', b('Asignar a:'), '.']) ]),
            p([b('Asignaciones registradas: '), NAsig, ' · ',
               a(href('/html/registro'), 'Ver registro de asignaciones')])
        ]),
        div(class(tarjeta), [
            h2('Opciones del sistema'),
            ol([ li(a(href('/html/academias'),    'Asignar profesores a academias')),
                 li(a(href('/html/cuerpos'),      'Asignar profesores a cuerpos académicos')),
                 li(a(href('/html/proyectos'),    'Asignar profesores a proyectos')),
                 li(a(href('/html/cursos'),       'Asignar al mejor profesor a un curso')),
                 li(a(href('/html/capacitacion'), 'Asignar profesores a cursos de capacitación')),
                 li(a(href('/html/buscar'),       'Buscar un profesor y sus asignaciones')) ]),
            p(['Extra: ', a(href('/html/comisiones'), 'asignación a comisiones'), ' y ',
               a(href('/html/profesores'), 'catálogo de profesores'), '.'])
        ]),
        div(class(tarjeta), [
            h2('¿Cómo se calcula el perfil?'),
            p('Para cada área de conocimiento se suma:'),
            ul([ li('Grado académico: licenciatura 1, maestría 2, doctorado 3'),
                 li('Especialidad igual al área: 4'),
                 li('Estudios en el área: licenciatura 2, maestría 3, doctorado 4'),
                 li('Acreditaciones del área: 3 c/u; acreditaciones generales (p. ej. PRODEP): 1 c/u'),
                 li('Cursos de capacitación tomados del área: 2 c/u'),
                 li('Cursos que domina del área: 1 c/u') ]),
            p(class(nota), 'Cuando una entidad tiene varias áreas se toma la que mejor encaja con el profesor. Cada opción agrega sus propias reglas (ver cada página).')
        ]),
        div(class(tarjeta), [
            h2('API REST (JSON)'),
            ul([ li(code('GET /api/profesores')),
                 li(code('GET /api/asignar/academias   [?id=ac_sw]')),
                 li(code('GET /api/asignar/cuerpos     [?id=ca01]')),
                 li(code('GET /api/asignar/proyectos   [?id=py01]')),
                 li(code('GET /api/asignar/cursos      [?id=bd101]')),
                 li(code('GET /api/asignar/capacitaciones [?id=cap02]')),
                 li(code('GET /api/asignar/comisiones')),
                 li(code('GET /api/profesor?empleado=1001   o   ?nombre=maria')) ])
        ])
    ]).

% ---------- Catálogo de profesores -----------------------------------
html_profesores(_Request) :-
    findall([E, \liga_prof(E), GT, AT, CT],
            ( profesor(E, _, G, Es, Dom), grado_texto(G, GT), area_texto(Es, AT),
              nombres_cursos(Dom, CT) ), Filas),
    pagina('Profesores', [
        div(class(tarjeta), \tabla(['#Empleado', 'Nombre', 'Grado', 'Especialidad',
                                    'Cursos que domina (mayor a menor)'], Filas)) ]).

% ---------- 1. Academias ---------------------------------------------
html_academias(Request) :-
    findall(A-N, academia(A, N, _, _), Pares),
    pagina_opcion(Request, '1. Asignación de profesores a academias',
        'Puntaje = perfil en el área de la academia + 2 por cada materia de la academia que el profesor domina. Cada profesor queda en una sola academia: el líder en la suya y los demás en la de mayor puntaje.',
        '/html/academias', 'Academia:', Pares, bloque_academia).

bloque_academia(A) -->
    { academia(A, Nom, Mat, Lid), nombre_prof(Lid, LN), nombres_cursos(Mat, MatT),
      ranking_academia(A, R),
      findall([\liga_prof(E), P, ND, Est, \accion(academia, A, E)],
              ( member(P-(E-ND), R),
                ( academia_asignada(E, A, M) -> motivo_texto(M, Est) ; Est = '—' ) ), Filas) },
    html(div(class(tarjeta), [
        h2(Nom),
        p([b('Líder: '), LN]),
        p([b('Materias: '), MatT]),
        \panel_asignacion(academia, A),
        \tabla(['Profesor', 'Puntaje', 'Materias de la academia que domina',
                'Recomendación', 'Acción'], Filas) ])).

% ---------- 2. Cuerpos académicos ------------------------------------
html_cuerpos(Request) :-
    findall(C-N, cuerpo_academico(C, N, _, _, _), Pares),
    umbral(cuerpo, U),
    format(atom(Nota), 'Requisitos: tener posgrado (maestría o doctorado) y un puntaje de perfil mayor o igual a ~w en alguna de las áreas del cuerpo académico. Cada profesor pertenece a un solo cuerpo académico (el de mayor puntaje).', [U]),
    pagina_opcion(Request, '2. Asignación de profesores a cuerpos académicos', Nota,
        '/html/cuerpos', 'Cuerpo académico:', Pares, bloque_ca).

bloque_ca(C) -->
    { cuerpo_academico(C, Nom, Linea, Lid, Est), estatus_texto(Est, EstT),
      nombre_prof(Lid, LN), areas_texto(C, AT),
      ranking_ca(C, R),
      findall([\liga_prof(E), GT, P, AsT, \accion(cuerpo, C, E)],
              ( member(P-E, R), profesor(E, _, G, _, _), grado_texto(G, GT),
                ( ca_asignado(E, C, M) -> motivo_texto(M, AsT) ; AsT = '—' ) ), Filas) },
    html(div(class(tarjeta), [
        h2(Nom),
        p([b('Línea de investigación: '), Linea]),
        p([b('Áreas: '), AT, ' · ', b('Estatus: '), EstT, ' · ', b('Líder: '), LN]),
        \panel_asignacion(cuerpo, C),
        \tabla(['Profesor', 'Grado', 'Puntaje', 'Recomendación', 'Acción'], Filas) ])).

% ---------- 3. Proyectos ---------------------------------------------
html_proyectos(Request) :-
    findall(P-N, proyecto(P, N, _, _, _, _, _, _), Pares),
    umbral(proyecto, U),
    format(atom(Nota), 'Candidatos: profesores que no son líder ni integrantes del proyecto y cuyo puntaje en las áreas del proyecto es mayor o igual a ~w. Se recomiendan los de mayor puntaje hasta completar el cupo.', [U]),
    pagina_opcion(Request, '3. Asignación de profesores a proyectos', Nota,
        '/html/proyectos', 'Proyecto:', Pares, bloque_proyecto).

bloque_proyecto(Py) -->
    { proyecto(Py, Nom, Obj, Ent, Lid, Int, FI, FE), proyecto_cupo(Py, Cupo),
      fecha_texto(FI, FIt), fecha_texto(FE, FEt), atomic_list_concat(Ent, ', ', EntT),
      areas_texto(Py, AT), nombre_prof(Lid, LN), lista_nombres(Int, IntT),
      recomendados_proyecto(Py, Recs),
      findall(P-E, ( profesor(E, _, _, _, _), mejor_area(E, Py, _, P) ), L0),
      sort(1, @>=, L0, Todos),
      findall([\liga_prof(E), P, Est, \accion(proyecto, Py, E)],
              ( member(P-E, Todos),
                ( memberchk(P-E, Recs) -> Est = 'Recomendado' ; Est = '—' ) ),
              Filas) },
    html(div(class(tarjeta), [
        h2(Nom),
        p([b('Objetivo: '), Obj]),
        p([b('Entregables: '), EntT]),
        p([b('Periodo: '), FIt, ' al ', FEt, ' · ', b('Áreas: '), AT]),
        p([b('Líder: '), LN, ' · ', b('Integrantes originales: '), IntT, ' · ',
           b('Cupo (sin el líder): '), Cupo]),
        \panel_asignacion(proyecto, Py),
        \tabla(['Profesor', 'Puntaje', 'Recomendación', 'Acción'], Filas) ])).

% ---------- 4. Cursos ------------------------------------------------
html_cursos(Request) :-
    findall(C-T, (curso(C, _, N, _, _), format(atom(T), '~w (~w)', [N, C])), Pares),
    pagina_opcion(Request, '4. Asignar al mejor profesor a un curso',
        'Solo se consideran los profesores que dominan el curso. Puntaje = perfil en el área del curso + bono según el lugar del curso en su lista de dominio (1º = 10, 2º = 8, 3º = 6, 4º = 4, resto = 2).',
        '/html/cursos', 'Curso:', Pares, bloque_curso).

bloque_curso(Id) -->
    { curso(Id, Cr, Nom, Obj, Ac), academia(Ac, AcN, _, _),
      ranking_curso(Id, R),
      findall([\liga_prof(E), P, Pos, \accion(curso, Id, E)], member(P-(E-Pos), R), Filas) },
    html(div(class(tarjeta), [
        h2(Nom),
        p([b('Clave: '), Id, ' · ', b('Créditos: '), Cr, ' · ', b('Academia: '), AcN]),
        p([b('Objetivo: '), Obj]),
        \panel_asignacion(curso, Id),
        h3('Profesores que dominan el curso'),
        \tabla(['Profesor', 'Puntaje', 'Lugar del curso en su lista', 'Acción'], Filas) ])).

% "Ver todas" en cursos: tabla resumen con el mejor profesor de cada curso
resumen_cursos -->
    { findall([a(href(H), CN), C, AcN, Mejor, Pt, Asig],
              ( curso(C, _, CN, _, Ac), academia(Ac, AcN, _, _),
                format(atom(H), '/html/cursos?id=~w', [C]),
                (   mejor_profesor_curso(C, E, P, _)
                ->  Mejor = \liga_prof(E), Pt = P
                ;   Mejor = 'Nadie lo domina', Pt = '—' ),
                (   asignado(curso, C, EA) -> Asig = \liga_prof(EA) ; Asig = '—' ) ), Filas) },
    html(div(class(tarjeta), [
        h2('Mejor profesor de cada curso'),
        p(class(nota), 'Da clic en un curso para asignarlo.'),
        \tabla(['Curso', 'Clave', 'Academia', 'Recomendado', 'Puntaje', 'Asignado'], Filas) ])).

resultado_curso([P-(E-_)|_]) -->
    html(p(class(destacado), [b('Profesor asignado: '), \liga_prof(E), ' (puntaje ', P, ')'])).
resultado_curso([]) -->
    html(p(class(destacado), 'Ningún profesor domina este curso.')).

% ---------- 5. Capacitación ------------------------------------------
html_capacitacion(Request) :-
    findall(C-N, curso_capacitacion(C, N, _, _, _, _), Pares),
    pagina_opcion(Request, '5. Asignación de profesores a cursos de capacitación',
        'Se asigna a los profesores que aún no han tomado el curso y cuyo perfil se relaciona con su área (por su especialidad o porque imparten cursos de esa área). La afinidad es el puntaje de perfil en esa área.',
        '/html/capacitacion', 'Curso de capacitación:', Pares, bloque_capacitacion).

bloque_capacitacion(C) -->
    { curso_capacitacion(C, Nom, Obj, H, FI, FC),
      fecha_texto(FI, FIt), fecha_texto(FC, FCt), areas_texto(C, AT),
      findall(E, capacitacion_tomada(E, C), Ya), lista_nombres(Ya, YaT),
      findall(P-E, ( profesor(E, _, _, _, _), mejor_area(E, C, _, P) ), L0),
      sort(1, @>=, L0, Todos),
      findall([\liga_prof(E), P, \accion(capacitacion, C, E)], member(P-E, Todos), Filas) },
    html(div(class(tarjeta), [
        h2(Nom),
        p([b('Objetivo: '), Obj]),
        p([b('Horas: '), H, ' · ', b('Periodo: '), FIt, ' al ', FCt, ' · ', b('Áreas: '), AT]),
        p([b('Ya lo tomaron: '), YaT]),
        \panel_asignacion(capacitacion, C),
        \tabla(['Profesor', 'Afinidad', 'Acción'], Filas) ])).

% ---------- Extra: Comisiones ----------------------------------------
html_comisiones(Request) :-
    findall(C-N, comision(C, N, _, _), Pares),
    pagina_opcion(Request, 'Asignación de profesores a comisiones',
        'Se recomiendan los profesores con mayor puntaje en las áreas de cada comisión, hasta completar su número de integrantes.',
        '/html/comisiones', 'Comisión:', Pares, bloque_comision).

bloque_comision(C) -->
    { comision(C, Nom, Obj, Cupo), areas_texto(C, AT),
      findall(P-E, ( profesor(E, _, _, _, _), mejor_area(E, C, _, P) ), L0),
      sort(1, @>=, L0, Todos),
      findall([\liga_prof(E), P, \accion(comision, C, E)], member(P-E, Todos), Filas) },
    html(div(class(tarjeta), [
        h2(Nom),
        p([b('Objetivo: '), Obj]),
        p([b('Áreas: '), AT, ' · ', b('Integrantes: '), Cupo]),
        \panel_asignacion(comision, C),
        \tabla(['Profesor', 'Puntaje', 'Acción'], Filas) ])).

% ---------- 6. Buscar profesor ---------------------------------------
html_buscar(Request) :-
    http_parameters(Request, [q(Q, [optional(true), default('')])]),
    (   Q == ''
    ->  Resultado = [p(class(nota), 'Escribe un número de empleado (p. ej. 1003) o parte del nombre (p. ej. maria).')]
    ;   buscar_profesor(Q, Emps),
        (   Emps == []
        ->  Resultado = [p(class(destacado), ['No se encontró ningún profesor con "', Q, '".'])]
        ;   findall(\ficha_profesor(E), member(E, Emps), Resultado)
        )
    ),
    pagina('6. Buscar un profesor y sus asignaciones', [
        \mensaje(Request),
        form([action('/html/buscar'), method(get), class(selector)],
             [ input([name(q), value(Q), placeholder('Número de empleado o nombre'), size(32)]),
               ' ', input([type(submit), value('Buscar')]) ])
        | Resultado ]).

ficha_profesor(E) -->
    { profesor(E, N, G, Es, Dom), grado_texto(G, GT), area_texto(Es, EsT),
      findall(li(CN), (member(C, Dom), curso(C, _, CN, _, _)), CursosLi),
      findall([NT, T, I, AT],
              (estudio(E, Ni, T, I, Ar), grado_texto(Ni, NT), area_texto(Ar, AT)), FEst),
      findall([AN, O, AT], (acreditacion(E, AN, O, Ar), area_texto(Ar, AT)), FAcr),
      findall([CN, H, FCt],
              ( capacitacion_tomada(E, C), curso_capacitacion(C, CN, _, H, _, FC),
                fecha_texto(FC, FCt) ), FCap),
      asignaciones_html(E, Asig) },
    html(div(class(tarjeta), [
        h2([N, ' (#', E, ')']),
        p([b('Grado: '), GT, ' · ', b('Especialidad: '), EsT]),
        h3('Asignaciones registradas'),
        \asignaciones_registradas(E),
        \form_asignar(E),
        h3('Recomendaciones del sistema (según su perfil)'),
        ul(Asig),
        h3('Cursos que domina (de mayor a menor)'),
        ol(CursosLi),
        h3('Estudios'),
        \tabla(['Nivel', 'Título', 'Institución', 'Área'], FEst),
        h3('Acreditaciones'),
        \tabla(['Acreditación', 'Organismo', 'Área'], FAcr),
        h3('Cursos de capacitación tomados'),
        \tabla(['Curso', 'Horas', 'Concluyó'], FCap) ])).

asignaciones_html(E, [ li([b('Academia: '), AcT]),
                       li([b('Cuerpo académico: '), CaT]),
                       li([b('Proyectos: '), PyT]),
                       li([b('Cursos a impartir: '), CuT]),
                       li([b('Cursos de capacitación: '), CapT]),
                       li([b('Comisiones: '), ComT]) ]) :-
    (   academia_asignada(E, Ac, M1)
    ->  academia(Ac, AcN, _, _), motivo_texto(M1, M1T),
        format(atom(AcT), '~w (~w)', [AcN, M1T])
    ;   AcT = '—' ),
    (   ca_asignado(E, Ca, M2)
    ->  cuerpo_academico(Ca, CaN, _, _, _), motivo_texto(M2, M2T),
        format(atom(CaT), '~w (~w)', [CaN, M2T])
    ;   ( posgrado(E) -> CaT = 'Ninguno (no alcanza el puntaje mínimo)'
                       ; CaT = 'Ninguno (requiere posgrado)' ) ),
    findall(T, ( rol_proyecto(E, P, Rol), proyecto(P, PN, _, _, _, _, _, _),
                 rol_texto(Rol, RT), format(atom(T), '~w (~w)', [PN, RT]) ), Pys),
    texto_lista(Pys, PyT),
    findall(CN, (curso(C, _, CN, _, _), mejor_profesor_curso(C, E, _, _)), Cus),
    texto_lista(Cus, CuT),
    findall(CN, ( curso_capacitacion(C, CN, _, _, _, _),
                  candidatos_capacitacion(C, L), memberchk(_-E, L) ), Caps),
    texto_lista(Caps, CapT),
    findall(CN, ( comision(C, CN, _, _), integrantes_comision(C, L2),
                  memberchk(_-E, L2) ), Coms),
    texto_lista(Coms, ComT).

texto_lista([], '—') :- !.
texto_lista(L, T) :- atomic_list_concat(L, '; ', T).

% Lista de asignaciones registradas de un profesor (con botón Quitar)
asignaciones_registradas(E) -->
    { tipos(Ts),
      findall(li([b([TT, ': ']), a(href(H), EN), ' ', Extra]),
              ( member(T, Ts), miembro(T, I, E), entidad(T, I, EN), tipo_texto(T, TT),
                ruta_tipo(T, R), format(atom(H), '~w?id=~w', [R, I]),
                (   fijo(T, I, E)
                ->  Extra = span(class(fijo), '(fijo)')
                ;   Extra = \boton('/html/quitar', [tipo=T, id=I, emp=E, volver=ficha], 'Quitar', quitar)
                ) ),
              Lis0),
      list_to_set(Lis0, Lis) },
    (   { Lis == [] }
    ->  html(p(class(nota), 'Todavía no tiene asignaciones registradas.'))
    ;   html(ul(class(registradas), Lis))
    ).

% Formulario para asignar al profesor a cualquier entidad
form_asignar(E) -->
    { tipos(Ts),
      findall(optgroup([label(TP)], Ops),
              ( member(T, Ts), tipo_plural(T, TP),
                findall(option([value(V)], Txt),
                        ( entidad(T, I, EN), \+ miembro(T, I, E),
                          format(atom(V), '~w:~w', [T, I]),
                          (   validar(T, I, E, ok) -> Txt = EN
                          ;   format(atom(Txt), '~w  (no cumple el perfil)', [EN]) ) ),
                        Ops),
                Ops \== [] ),
              Grupos) },
    html(form([action('/html/asignar'), method(post), class(selector)],
              [ input([type(hidden), name(emp), value(E)]),
                input([type(hidden), name(volver), value(ficha)]),
                label([for(destino)], b('Asignar a:')),
                select([name(destino), id(destino), required(required)],
                       [ option([value(''), disabled(disabled), selected(selected)], '— Selecciona —')
                       | Grupos ]),
                input([type(submit), value('Asignar')]) ])).

% ---------- Acciones: asignar, quitar, aplicar, reiniciar ------------

% POST /html/asignar   emp, (tipo + id) o destino=tipo:id, [volver]
html_asignar(Request) :-
    http_parameters(Request, [ emp(E, [integer]),
                               tipo(T0, [optional(true)]),
                               id(I0, [optional(true)]),
                               destino(D, [optional(true)]),
                               volver(V, [optional(true), default(entidad)]) ]),
    (   nonvar(D), atomic_list_concat(Partes, ':', D), Partes = [T, I]
    ->  true
    ;   T = T0, I = I0
    ),
    (   nonvar(T), nonvar(I), entidad(T, I, NomEnt), profesor(E, NomP, _, _, _)
    ->  validar(T, I, E, Res),
        (   Res == ok
        ->  assertz(asignado(T, I, E)), guardar_asignaciones,
            format(atom(Msg), 'Se asignó a ~w a «~w».', [NomP, NomEnt]), K = ok
        ;   Res = no(Motivo),
            format(atom(Msg), 'No se pudo asignar a ~w a «~w»: ~w', [NomP, NomEnt, Motivo]), K = err
        )
    ;   Msg = 'Datos de asignación no válidos.', K = err
    ),
    redirigir(Request, V, T, I, E, K, Msg).

% POST /html/quitar   tipo, id, emp, [volver]
html_quitar(Request) :-
    http_parameters(Request, [ tipo(T, []), id(I, []), emp(E, [integer]),
                               volver(V, [optional(true), default(entidad)]) ]),
    (   fijo(T, I, E)
    ->  Msg = 'Es una asignación fija (líder o integrante original); no se puede quitar.', K = err
    ;   retract(asignado(T, I, E))
    ->  guardar_asignaciones,
        nombre_prof(E, N), entidad(T, I, EN),
        format(atom(Msg), 'Se quitó a ~w de «~w».', [N, EN]), K = ok
    ;   Msg = 'Esa asignación no existe.', K = err
    ),
    redirigir(Request, V, T, I, E, K, Msg).

% POST /html/aplicar   tipo, id   -> asigna a los recomendados que cumplen
html_aplicar(Request) :-
    http_parameters(Request, [ tipo(T, []), id(I, []) ]),
    (   entidad(T, I, _)
    ->  aplicar_recomendacion(T, I, As, Rs),
        (   As == []
        ->  M1 = 'No se asignó a nadie.'
        ;   length(As, NA), lista_nombres(As, AsT),
            format(atom(M1), 'Se asignaron ~w profesor(es): ~w.', [NA, AsT])
        ),
        (   Rs == []
        ->  Msg = M1, K = ok
        ;   lista_nombres(Rs, RsT),
            format(atom(Msg), '~w No cumplieron los requisitos: ~w (en la tabla aparece el motivo).', [M1, RsT]),
            ( As == [] -> K = err ; K = ok )
        )
    ;   Msg = 'Datos no válidos.', K = err
    ),
    redirigir(Request, entidad, T, I, _, K, Msg).

% POST /html/reiniciar   -> borra todas las asignaciones registradas
html_reiniciar(Request) :-
    retractall(asignado(_, _, _)),
    guardar_asignaciones,
    redirigir(Request, registro, _, _, _, ok, 'Se borraron todas las asignaciones registradas.').

% Regresa a la página de donde vino, con el mensaje en la URL
redirigir(Request, Volver, T, I, E, K, Msg) :-
    uri_encoded(query_value, Msg, M),
    (   Volver == ficha, nonvar(E)
    ->  format(atom(U), '/html/buscar?q=~w&~w=~w', [E, K, M])
    ;   Volver == registro
    ->  format(atom(U), '/html/registro?~w=~w', [K, M])
    ;   nonvar(T), nonvar(I), ruta_tipo(T, R)
    ->  format(atom(U), '~w?id=~w&~w=~w', [R, I, K, M])
    ;   format(atom(U), '/home?~w=~w', [K, M])
    ),
    http_redirect(see_other, U, Request).

% ---------- Registro de todas las asignaciones ------------------------
html_registro(Request) :-
    tipos(Ts),
    findall([TT, a(href(H), EN), \liga_prof(E),
             \boton('/html/quitar', [tipo=T, id=I, emp=E, volver=registro], 'Quitar', quitar)],
            ( member(T, Ts), asignado(T, I, E), tipo_texto(T, TT), entidad(T, I, EN),
              ruta_tipo(T, R), format(atom(H), '~w?id=~w', [R, I]) ),
            Filas),
    length(Filas, N),
    pagina('Registro de asignaciones', [
        \mensaje(Request),
        p(class(nota), 'Asignaciones hechas desde la interfaz. Los líderes y los integrantes originales de los proyectos son fijos y no aparecen aquí. Se guardan en el archivo asignaciones_guardadas.pl, en la misma carpeta del programa, así que se conservan al cerrar Prolog.'),
        div(class(tarjeta), [ p([b('Total de asignaciones: '), N]),
                              \tabla(['Tipo', 'Asignado a', 'Profesor', 'Acción'], Filas) ]),
        \boton_borrar(N) ]).

boton_borrar(0) --> !, [].
boton_borrar(_) -->
    boton('/html/reiniciar', [], 'Borrar todas las asignaciones', quitar).

% =====================================================================
% 8. MENÚ EN CONSOLA
% ---------------------------------------------------------------------
% En la consola de SWI-Prolog escribe:   menu.
% Elige una opción escribiendo su número y presionando Enter.
% =====================================================================

:- initialization(format("~n>> Escribe  menu.  para usar el menú en consola.~n~n")).

menu :-
    repeat,
    mostrar_menu,
    leer_numero('Elige una opción: ', Op),
    (   Op == 0
    ->  !, format("~nHasta luego.~n")
    ;   (   catch(ejecutar_opcion(Op), Error, (print_message(error, Error)))
        ->  true
        ;   true
        ),
        fail
    ).

mostrar_menu :-
    format("~n  ~`=t~56|~n"),
    format("    ASIGNACIÓN DE PROFESORES · FCI UNACAR~n"),
    format("  ~`=t~56|~n"),
    format("    1. Asignar profesores a academias~n"),
    format("    2. Asignar profesores a cuerpos académicos~n"),
    format("    3. Asignar profesores a proyectos~n"),
    format("    4. Asignar al mejor profesor a un curso~n"),
    format("    5. Asignar profesores a cursos de capacitación~n"),
    format("    6. Buscar un profesor y sus asignaciones~n"),
    format("    7. Asignar profesores a comisiones (extra)~n"),
    format("    8. Ver catálogo de profesores~n"),
    format("    0. Salir~n"),
    format("  ~`=t~56|~n").

% ---------- Opciones -------------------------------------------------
ejecutar_opcion(1) :- !,
    findall(A-N, academia(A, N, _, _), Ps),
    (   elegir('ACADEMIAS', Ps, A) -> consola_academia(A), pausa ; true ).
ejecutar_opcion(2) :- !,
    findall(C-N, cuerpo_academico(C, N, _, _, _), Ps),
    (   elegir('CUERPOS ACADÉMICOS', Ps, C) -> consola_ca(C), pausa ; true ).
ejecutar_opcion(3) :- !,
    findall(P-N, proyecto(P, N, _, _, _, _, _, _), Ps),
    (   elegir('PROYECTOS', Ps, P) -> consola_proyecto(P), pausa ; true ).
ejecutar_opcion(4) :- !,
    findall(C-T, (curso(C, _, N, _, _), format(atom(T), '~w (~w)', [N, C])), Ps),
    (   elegir('CURSOS', Ps, C) -> consola_curso(C), pausa ; true ).
ejecutar_opcion(5) :- !,
    findall(C-N, curso_capacitacion(C, N, _, _, _, _), Ps),
    (   elegir('CURSOS DE CAPACITACIÓN', Ps, C) -> consola_capacitacion(C), pausa ; true ).
ejecutar_opcion(6) :- !,
    leer_texto('\nNúmero de empleado o nombre (Enter para regresar): ', T),
    (   T == ''
    ->  true
    ;   buscar_profesor(T, Emps),
        (   Emps == []
        ->  format("~nNo se encontró ningún profesor con \"~w\".~n", [T])
        ;   forall(member(E, Emps), consola_profesor(E))
        ),
        pausa
    ).
ejecutar_opcion(7) :- !,
    forall(comision(C, _, _, _), consola_comision(C)),
    pausa.
ejecutar_opcion(8) :- !,
    titulo('CATÁLOGO DE PROFESORES'),
    fila([10, 26, 14, 26], ['#Emp', 'Nombre', 'Grado', 'Especialidad']),
    linea,
    forall(profesor(E, N, G, Es, _),
           ( grado_texto(G, GT), area_texto(Es, AT), fila([10, 26, 14, 26], [E, N, GT, AT]) )),
    pausa.
ejecutar_opcion(_) :-
    format("~nOpción no válida.~n").

% ---------- 1. Academias ---------------------------------------------
consola_academia(A) :-
    academia(A, Nom, Mat, Lid), nombre_prof(Lid, LN), nombres_cursos(Mat, MT),
    findall(E, academia_asignada(E, A, _), As), lista_nombres(As, AsT),
    titulo(Nom),
    format("  Líder:    ~w~n  Materias: ~w~n", [LN, MT]),
    format("~n  >> PROFESORES ASIGNADOS: ~w~n~n", [AsT]),
    format("  Ranking por perfil (perfil + 2 por cada materia que domina):~n"),
    fila([26, 9, 12, 24], ['Profesor', 'Puntaje', 'Materias', 'Asignación']),
    linea,
    ranking_academia(A, R),
    forall(member(P-(E-ND), R),
           ( nombre_prof(E, N),
             ( academia_asignada(E, A, M) -> motivo_texto(M, MT2) ; MT2 = '—' ),
             fila([26, 9, 12, 24], [N, P, ND, MT2]) )).

% ---------- 2. Cuerpos académicos ------------------------------------
consola_ca(C) :-
    cuerpo_academico(C, Nom, Linea, Lid, Est), estatus_texto(Est, EstT),
    nombre_prof(Lid, LN), areas_texto(C, AT), umbral(cuerpo, U),
    findall(E, ca_asignado(E, C, _), Ints), lista_nombres(Ints, IntsT),
    titulo(Nom),
    format("  Línea de investigación: ~w~n  Áreas: ~w~n  Estatus: ~w   Líder: ~w~n",
           [Linea, AT, EstT, LN]),
    format("~n  >> INTEGRANTES ASIGNADOS: ~w~n~n", [IntsT]),
    format("  Requisitos: posgrado y puntaje >= ~w~n", [U]),
    fila([26, 14, 9, 10, 24], ['Profesor', 'Grado', 'Puntaje', 'Elegible', 'Asignación']),
    linea,
    ranking_ca(C, R),
    forall(member(P-E, R),
           ( profesor(E, N, G, _, _), grado_texto(G, GT),
             ( elegible_ca(E, C, _) -> El = 'Sí' ; El = 'No' ),
             ( ca_asignado(E, C, M) -> motivo_texto(M, MT) ; MT = '—' ),
             fila([26, 14, 9, 10, 24], [N, GT, P, El, MT]) )).

% ---------- 3. Proyectos ---------------------------------------------
consola_proyecto(Py) :-
    proyecto(Py, Nom, Obj, Ent, Lid, Int, FI, FE), proyecto_cupo(Py, Cupo),
    fecha_texto(FI, FIt), fecha_texto(FE, FEt), atomic_list_concat(Ent, ', ', EntT),
    areas_texto(Py, AT), nombre_prof(Lid, LN), lista_nombres(Int, IntT),
    umbral(proyecto, U),
    titulo(Nom),
    format("  Objetivo:    ~w~n  Entregables: ~w~n  Periodo:     ~w al ~w~n  Áreas:       ~w~n",
           [Obj, EntT, FIt, FEt, AT]),
    format("  Líder: ~w   Integrantes actuales: ~w   Cupo: ~w~n", [LN, IntT, Cupo]),
    recomendados_proyecto(Py, Recs),
    findall(E, member(_-E, Recs), RecsE), lista_nombres(RecsE, RecsT),
    format("~n  >> SE RECOMIENDA ASIGNAR: ~w~n~n", [RecsT]),
    format("  Candidatos (puntaje >= ~w):~n", [U]),
    fila([26, 9, 26], ['Candidato', 'Puntaje', 'Estado']),
    linea,
    candidatos_proyecto(Py, Cands),
    (   Cands == []
    ->  format("  Sin candidatos.~n")
    ;   forall(member(P-E, Cands),
               ( nombre_prof(E, N),
                 ( memberchk(P-E, Recs) -> S = 'Asignar al proyecto' ; S = 'En espera (cupo lleno)' ),
                 fila([26, 9, 26], [N, P, S]) ))
    ).

% ---------- 4. Cursos ------------------------------------------------
consola_curso(C) :-
    curso(C, Cr, Nom, Obj, Ac), academia(Ac, AcN, _, _),
    titulo(Nom),
    format("  Clave: ~w   Créditos: ~w~n  Academia: ~w~n  Objetivo: ~w~n", [C, Cr, AcN, Obj]),
    ranking_curso(C, R),
    (   R = [P0-(E0-_)|_]
    ->  nombre_prof(E0, N0),
        format("~n  >> PROFESOR ASIGNADO: ~w (puntaje ~w)~n~n", [N0, P0]),
        format("  Profesores que dominan el curso:~n"),
        fila([26, 9, 20], ['Profesor', 'Puntaje', 'Lugar en su lista']),
        linea,
        forall(member(P-(E-Pos), R),
               ( nombre_prof(E, N), format(atom(PosT), '~wº', [Pos]),
                 fila([26, 9, 20], [N, P, PosT]) ))
    ;   format("~n  >> Ningún profesor domina este curso.~n")
    ).

% ---------- 5. Cursos de capacitación --------------------------------
consola_capacitacion(C) :-
    curso_capacitacion(C, Nom, Obj, H, FI, FC),
    fecha_texto(FI, FIt), fecha_texto(FC, FCt), areas_texto(C, AT),
    findall(E, capacitacion_tomada(E, C), Ya), lista_nombres(Ya, YaT),
    titulo(Nom),
    format("  Objetivo: ~w~n  Horas: ~w   Periodo: ~w al ~w~n  Áreas: ~w~n",
           [Obj, H, FIt, FCt, AT]),
    format("  Ya lo tomaron: ~w~n~n", [YaT]),
    candidatos_capacitacion(C, Cands),
    format("  >> PROFESORES ASIGNADOS:~n"),
    fila([26, 9], ['Profesor', 'Afinidad']),
    linea,
    (   Cands == []
    ->  format("  Ninguno.~n")
    ;   forall(member(P-E, Cands), (nombre_prof(E, N), fila([26, 9], [N, P])))
    ).

% ---------- 6. Ficha del profesor ------------------------------------
consola_profesor(E) :-
    profesor(E, N, G, Es, Dom), grado_texto(G, GT), area_texto(Es, EsT),
    format(atom(T), '~w (#~w)', [N, E]),
    titulo(T),
    format("  Grado: ~w   Especialidad: ~w~n", [GT, EsT]),
    format("~n  ASIGNACIONES REGISTRADAS~n"),
    tipos(Ts),
    (   member(T0, Ts), miembro(T0, _, E)
    ->  forall(( member(T1, Ts), miembro(T1, I1, E), entidad(T1, I1, EN1), tipo_texto(T1, TT1) ),
               format("   - ~w: ~w~n", [TT1, EN1]))
    ;   format("   —~n")
    ),
    format("~n  RECOMENDACIONES DEL SISTEMA~n"),
    asignaciones_html(E, Lis),
    forall(member(li([b(Et), Tx]), Lis), format("   - ~w~w~n", [Et, Tx])),
    format("~n  CURSOS QUE DOMINA (de mayor a menor)~n"),
    forall(nth1(I, Dom, C), (curso(C, _, CN, _, _), format("   ~w. ~w~n", [I, CN]))),
    format("~n  ESTUDIOS~n"),
    forall(estudio(E, Ni, Ti, In, _),
           ( grado_texto(Ni, NT), format("   - ~w: ~w (~w)~n", [NT, Ti, In]) )),
    format("~n  ACREDITACIONES~n"),
    (   acreditacion(E, _, _, _)
    ->  forall(acreditacion(E, AN, O, _), format("   - ~w (~w)~n", [AN, O]))
    ;   format("   —~n")
    ),
    format("~n  CURSOS DE CAPACITACIÓN TOMADOS~n"),
    (   capacitacion_tomada(E, _)
    ->  forall(( capacitacion_tomada(E, C), curso_capacitacion(C, CN, _, H, _, _) ),
               format("   - ~w (~w h)~n", [CN, H]))
    ;   format("   —~n")
    ).

% ---------- 7. Comisiones --------------------------------------------
consola_comision(C) :-
    comision(C, Nom, Obj, Cupo), areas_texto(C, AT),
    titulo(Nom),
    format("  Objetivo: ~w~n  Áreas: ~w   Integrantes: ~w~n~n", [Obj, AT, Cupo]),
    fila([26, 9], ['Profesor asignado', 'Puntaje']),
    linea,
    integrantes_comision(C, L),
    forall(member(P-E, L), (nombre_prof(E, N), fila([26, 9], [N, P]))).

% ---------- Utilidades de consola ------------------------------------

% elegir(+Titulo, +ListaIdNombre, -Id): muestra una lista numerada y
% devuelve el Id elegido. Falla si el usuario elige 0 (regresar).
elegir(Titulo, Pares, Id) :-
    format("~n  ~w~n", [Titulo]),
    forall(nth1(I, Pares, _-N), format("    ~d. ~w~n", [I, N])),
    format("    0. Regresar al menú~n"),
    leer_numero('Elige una opción: ', K),
    (   K == 0
    ->  fail
    ;   nth1(K, Pares, Id0-_)
    ->  Id = Id0
    ;   format("Opción no válida.~n"),
        elegir(Titulo, Pares, Id)
    ).

% Lee una línea; ignora líneas vacías. Fin de archivo = ''.
leer_texto(Prompt, Texto) :-
    format("~w", [Prompt]), flush_output,
    read_line_to_string(user_input, S0),
    (   S0 == end_of_file
    ->  Texto = ''
    ;   split_string(S0, "", " \t\r", [S]),
        atom_string(Texto, S)
    ).

% Lee un número entero; vuelve a preguntar si la línea está vacía.
% Fin de archivo = 0 (salir/regresar); texto no numérico = -1.
leer_numero(Prompt, N) :-
    format("~w", [Prompt]), flush_output,
    read_line_to_string(user_input, S0),
    (   S0 == end_of_file
    ->  N = 0
    ;   split_string(S0, "", " \t\r", [S]),
        (   S == ""
        ->  leer_numero(Prompt, N)
        ;   catch(number_string(N0, S), _, fail), integer(N0)
        ->  N = N0
        ;   N = -1
        )
    ).

pausa :-
    format("~nPresiona Enter para volver al menú..."), flush_output,
    read_line_to_string(user_input, _).

titulo(T) :- format("~n  === ~w ===~n~n", [T]).

linea :- format("  ~`-t~75|~n").

% fila(+Anchos, +Celdas): imprime una fila con columnas de ancho fijo.
fila(Anchos, Celdas) :-
    findall(F, (member(A, Anchos), format(atom(F), '~~w~~t~~~d+', [A])), Fs),
    atomic_list_concat(['  '|Fs], Formato),
    format(Formato, Celdas), nl.
