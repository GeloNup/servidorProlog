# Actividad 3: Sistema de asignación de profesores

**Facultad de Ciencias de la Información · UNACAR**

**Grupo:** PA · Lunes 13:00

**Archivo del programa:** `actividad3.pl` (SWI-Prolog)

### Elaborado por

| Integrante | Matrícula |
|---|---|
| Angel Emilio Martínez Camacho |194043 |
| Mariana Maynez Jacinto |191535 |

---

## 1. El problema

La facultad necesita asignar a sus profesores, **según su preparación y especialidad**, a:

- academias
- cuerpos académicos
- proyectos
- comisiones
- cursos a impartir
- cursos de capacitación

Además debe llevar el control de sus **estudios** (licenciatura, maestría y doctorado), sus **acreditaciones** y los **cursos de capacitación** que ha tomado.

El sistema debe permitir:

1. Asignar profesores a academias según su perfil de estudios y capacitación.
2. Asignar profesores a cuerpos académicos según su perfil.
3. Asignar profesores a proyectos según su perfil.
4. Asignar al mejor profesor a un curso según su perfil.
5. Asignar profesores a cursos de capacitación según su perfil.
6. Buscar un profesor y sus asignaciones.

---

## 2. La solución

Es un **sistema basado en conocimiento** hecho en Prolog, con la misma estructura que el ejemplo visto en clase:

1. **Base de conocimiento:** hechos sobre profesores, estudios, academias, proyectos, etc.
2. **Reglas:** calculan el perfil de cada profesor y deciden las asignaciones.
3. **Servidor web:** ofrece una **API REST** (JSON) y una **interfaz HTML** para usar el sistema desde el navegador.

También incluye un **menú en consola** como alternativa.

---

## 3. Cómo ejecutarlo

1. Instalar **SWI-Prolog** (swi-prolog.org).
2. Abrir `actividad3.pl` con doble clic, con *File → Consult*, o desde una terminal:
   ```
   swipl actividad3.pl
   ```
3. En la consola debe aparecer `% Started server at http://localhost:8080/`.
4. Abrir en el navegador: **http://localhost:8080/home**
5. Para detenerlo, escribir en la consola de Prolog:
   ```prolog
   http_stop_server(8080, []).
   halt.
   ```

> Para usar el menú en consola, escribe `menu.` en la consola de Prolog.

---

## 4. Base de conocimiento

| Hecho | Datos | Registros |
|---|---|---|
| `profesor/5` | #empleado, nombre, grado académico, especialidad, cursos que domina (de mayor a menor) | 8 |
| `estudio/5` | profesor, nivel (licenciatura / maestría / doctorado), título, institución, área | 18 |
| `acreditacion/4` | profesor, nombre, organismo, área | 11 |
| `capacitacion_tomada/2` | profesor, curso de capacitación | 8 |
| `academia/4` | id, nombre, materias asignadas, líder | 5 |
| `cuerpo_academico/5` | id, nombre, línea de investigación, líder, estatus | 3 |
| `proyecto/8` | id, nombre, objetivo, entregables, líder, integrantes, fecha de inicio, fecha de entrega | 3 |
| `curso/5` | id, créditos, nombre, objetivo, academia | 14 |
| `curso_capacitacion/6` | id, nombre, objetivo, número de horas, fecha de inicio, fecha de conclusión | 8 |
| `comision/4` | id, nombre, objetivo, número de integrantes | 3 |
| `area/2` y `area_de/2` | áreas de conocimiento y el área de cada entidad | — |

Ejemplo:

```prolog
profesor(1003, 'María López Gómez', doctorado, bases_datos, [bd101, bd201, prog101]).
estudio(1003, doctorado, 'Doctorado en Ciencias de la Información', 'UNAM', bases_datos).
acreditacion(1003, 'Oracle Database SQL Certified Associate', 'Oracle', bases_datos).
```

---

## 5. ¿Cómo se calcula el perfil?

Para comparar a un profesor con una academia, proyecto, curso, etc., se calcula su **puntaje de perfil** en el área de esa entidad (regla `perfil/4`):

| Concepto | Puntos |
|---|---|
| Grado académico | Licenciatura 1, Maestría 2, Doctorado 3 |
| Especialidad igual al área | 4 |
| Estudios en el área | Licenciatura 2, Maestría 3, Doctorado 4 |
| Acreditación del área | 3 cada una |
| Acreditación general (p. ej. PRODEP) | 1 cada una |
| Capacitación tomada del área | 2 cada una |
| Curso que domina del área | 1 cada uno |

Si la entidad tiene varias áreas (por ejemplo, *Redes y Seguridad*), se toma la que mejor encaja con el profesor.

---

## 6. Reglas de cada opción

| Opción | Regla principal | Criterio |
|---|---|---|
| **1. Academias** | `academia_asignada/3` | Perfil + 2 puntos por cada materia de la academia que domina. Cada profesor pertenece a **una sola** academia (la de mayor puntaje); el líder se queda en la suya. |
| **2. Cuerpos académicos** | `ca_asignado/3` | Requiere **posgrado** (maestría o doctorado) y un puntaje **≥ 10**. Un profesor pertenece a un solo cuerpo académico. |
| **3. Proyectos** | `recomendados_proyecto/2` | Puntaje **≥ 8**. No se cuenta al líder ni a los integrantes actuales, y se recomienda a los mejores hasta llenar el **cupo**. |
| **4. Mejor profesor para un curso** | `mejor_profesor_curso/4` | Solo cuentan quienes **dominan** el curso. Puntaje = perfil + bono según el lugar del curso en su lista (1.º = 10, 2.º = 8, 3.º = 6, 4.º = 4, resto = 2). Gana el puntaje más alto. |
| **5. Cursos de capacitación** | `candidatos_capacitacion/2` | Se asigna a quien **no lo ha tomado** y cuyo perfil se relaciona con el área del curso. |
| **6. Buscar profesor** | `buscar_profesor/2` | Busca por número de empleado o por nombre, sin importar mayúsculas ni acentos. Muestra datos, estudios, acreditaciones, capacitaciones y asignaciones. |
| *Extra: Comisiones* | `integrantes_comision/2` | Mayor puntaje en las áreas de la comisión, hasta llenar su número de integrantes. |

### Recomendar y asignar

- El sistema **recomienda** a los profesores adecuados aplicando las reglas anteriores.
- El usuario **asigna**, ya sea profesor por profesor o aplicando la recomendación completa.
- Antes de aceptar una asignación, el sistema **valida el perfil** (regla `validar/4`). Si el profesor no cumple, la rechaza y explica el motivo, por ejemplo: *"Requiere posgrado"* o *"No domina este curso"*.
- Las asignaciones se guardan en `asignaciones_guardadas.pl`, así que se conservan al cerrar Prolog.
- Los líderes y los integrantes originales de los proyectos son **fijos**.

---

## 7. Uso de la interfaz

En **http://localhost:8080/home**, la barra superior tiene las opciones **1 a 6**, *Comisiones*, *Profesores* y *Registro de asignaciones*.

1. Entra a una opción (por ejemplo **1. Academias**).
2. Elige la academia en la lista y presiona **Asignar**.
3. Verás:
   - los profesores **asignados**,
   - la **recomendación del sistema**, con el botón **Aplicar recomendación**,
   - una tabla con el puntaje de cada profesor y un botón **Asignar** o **Quitar**. Si un profesor no cumple, aparece el motivo en lugar del botón.
4. En **6. Buscar profesor** puedes ver la ficha de un profesor y asignarlo a cualquier entidad con **Asignar a:**.
5. **Registro de asignaciones** muestra todo lo asignado.

---

## 8. Endpoints

### API REST (JSON)

| Método y ruta | Descripción |
|---|---|
| `GET /api/profesores` | Lista de profesores |
| `GET /api/asignar/academias[?id=ac_sw]` | Asignación a academias / ranking de una academia |
| `GET /api/asignar/cuerpos[?id=ca01]` | Asignación a cuerpos académicos |
| `GET /api/asignar/proyectos[?id=py01]` | Profesores recomendados para proyectos |
| `GET /api/asignar/cursos[?id=bd101]` | Mejor profesor por curso / ranking de un curso |
| `GET /api/asignar/capacitaciones[?id=cap02]` | Asignación a cursos de capacitación |
| `GET /api/asignar/comisiones` | Integrantes de comisiones |
| `GET /api/profesor?empleado=1001` o `?nombre=maria` | Ficha y asignaciones de un profesor |

### Vistas HTML

`/home`, `/html/academias`, `/html/cuerpos`, `/html/proyectos`, `/html/cursos`, `/html/capacitacion`, `/html/buscar`, `/html/comisiones`, `/html/profesores`, `/html/registro`

### Acciones de la interfaz (POST)

`/html/asignar`, `/html/quitar`, `/html/aplicar`, `/html/reiniciar`

> La API JSON devuelve lo que el sistema **recomienda**. Las asignaciones hechas con los botones se ven en la interfaz.

---

## 9. Consultas de ejemplo en la consola

```prolog
?- perfil(1001, inteligencia_artificial, Puntos, Desglose).
?- academia_asignada(1005, Academia, Motivo).
?- elegible_ca(1004, ca02, Puntaje).
?- recomendados_proyecto(py01, Lista).
?- mejor_profesor_curso(bd101, Profesor, Puntaje, Lugar).
?- candidatos_capacitacion(cap02, Lista).
?- buscar_profesor(maria, Lista).
?- validar(cuerpo, ca01, 1005, Resultado).   % Resultado = no('Requiere posgrado ...')
```

---

## 10. Supuestos

El enunciado no especifica algunos detalles, así que se definieron estos:

- **Áreas de conocimiento** (software, bases de datos, redes, seguridad, IA, matemáticas, multimedia, educación) para poder comparar el perfil del profesor con cada entidad.
- **Puntajes mínimos:** 10 para cuerpos académicos y 8 para proyectos.
- **Cupo** de integrantes para proyectos y comisiones.
- Un profesor pertenece a **una sola academia** y a **un solo cuerpo académico**. Cada curso tiene **un solo profesor**.
- Los datos de profesores, cursos, proyectos, etc. son **de ejemplo**.

**Limitación conocida:** la regla del mejor profesor no limita la carga de cursos, así que un mismo profesor puede resultar el mejor en varios cursos de su área.

---

## 11. Estructura del archivo `actividad3.pl`

| Sección | Contenido |
|---|---|
| 1. Base de conocimiento | Hechos de todas las entidades |
| 2. Perfil del profesor | `perfil/4`, `mejor_area/4`, `posgrado/1` |
| 3. Reglas de asignación | Una regla por cada opción (1 a 6) y comisiones |
| 3b. Asignaciones registradas | `asignado/3` (dinámico), `validar/4`, guardar y cargar del archivo |
| 4. Utilidades | Textos, fechas, normalización de acentos |
| 5. Servidor | Módulos HTTP y rutas (`http_handler`) |
| 6. API REST | Respuestas en JSON |
| 7. Vistas HTML | Páginas de la interfaz y acciones de los botones |
| 8. Menú en consola | `menu.` |
