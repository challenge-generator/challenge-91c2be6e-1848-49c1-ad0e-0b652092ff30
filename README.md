# Optimización de Servidores de Aplicación

En el contexto de una plataforma de banca en línea, se requiere implementar y optimizar servidores de aplicación como Apache Tomcat o IBM Websphere para garantizar un rendimiento óptimo y una alta disponibilidad. Los servidores deben manejar un tráfico de 5 000 solicitudes por segundo con una latencia máxima de 200 ms y un tiempo de actividad del 99.9%. El sistema debe ser capaz de recuperarse automáticamente de caídas temporales en los servicios downstream y mantener la consistencia de los datos durante las transacciones.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | Manejo de Middleware |
| **Nivel** | senior-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 4 semanas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y generará un ZIP listo para usar.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Un IDE o editor de código.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y generará un archivo ZIP descargable. Descárgalo y extráelo en la carpeta donde quieras trabajar.
- Verifica que el proyecto arranca sin errores.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no genera el ZIP automáticamente al terminar el análisis, escríbele: "genera el ZIP ahora".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Implementación Inicial

**Objetivo:** Implementar un servidor de aplicación básico que pueda manejar solicitudes HTTP y persistir datos en una base de datos relacional.

**Tiempo estimado:** 1 semana

**Instrucciones:**

- Configura un servidor de aplicación para que acepte y procese solicitudes HTTP.
- Implementa la persistencia de datos en una base de datos relacional.
- Asegura que el servidor pueda manejar al menos 1 000 solicitudes por segundo con una latencia máxima de 500 ms.

**Entregable:** Servidor de aplicación operativo con persistencia de datos.

<details>
<summary>Pistas de conocimiento</summary>

- Considera la configuración del pool de conexiones a la base de datos para mejorar el rendimiento.
- Evalúa diferentes estrategias de caching para reducir la latencia.

</details>

### Fase 2: Optimización de Rendimiento

**Objetivo:** Optimizar el servidor de aplicación para manejar un tráfico de 5 000 solicitudes por segundo con una latencia máxima de 200 ms.

**Tiempo estimado:** 2 semanas

**Instrucciones:**

- Identifica y elimina cuellos de botella en el servidor de aplicación.
- Implementa técnicas de escalado horizontal y vertical.
- Asegura que el servidor pueda recuperarse automáticamente de caídas temporales en los servicios downstream.

**Entregable:** Servidor de aplicación optimizado para manejar 5 000 solicitudes por segundo con una latencia máxima de 200 ms.

<details>
<summary>Pistas de conocimiento</summary>

- Considera el uso de cargadores de clase y el tuning de la JVM.
- Evalúa la implementación de un balanceador de carga para el escalado horizontal.

</details>

### Fase 3: Alta Disponibilidad y Recuperación

**Objetivo:** Implementar medidas de alta disponibilidad y recuperación para garantizar un tiempo de actividad del 99.9%.

**Tiempo estimado:** 1 semana

**Instrucciones:**

- Configura el servidor de aplicación para soportar fallos y recuperarse automáticamente.
- Implementa mecanismos de replicación y failover para la base de datos.
- Asegura que el sistema mantenga la consistencia de los datos durante las transacciones.
- Documenta las decisiones tomadas y los trade-offs considerados.

**Entregable:** Servidor de aplicación con alta disponibilidad y recuperación automática, documentado con decisiones y trade-offs.

<details>
<summary>Pistas de conocimiento</summary>

- Considera el uso de clusters y tecnologías de alta disponibilidad como Apache Zookeeper.
- Evalúa diferentes estrategias de replicación y failover para la base de datos.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es un servidor de aplicación y cuáles son sus componentes principales?
- **paraQueSirve**: ¿Para qué sirve un servidor de aplicación en una plataforma de banca en línea?
- **comoSeUsa**: ¿Cómo se usa un servidor de aplicación para manejar solicitudes HTTP y persistir datos en una base de datos?
- **erroresComunes**: ¿Cuáles son los errores comunes al implementar y optimizar un servidor de aplicación?
- **queDecisionesImplica**: ¿Qué decisiones implica la implementación y optimización de un servidor de aplicación para garantizar alta disponibilidad y recuperación?

## Criterios de Evaluacion

- Implementación de un servidor de aplicación básico.
- Optimización del servidor para manejar 5 000 solicitudes por segundo con una latencia máxima de 200 ms.
- Implementación de medidas de alta disponibilidad y recuperación.
- Documentación de decisiones y trade-offs considerados.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT). Devuelve un ZIP con el proyecto. Sirve si no tenes un agente en el IDE.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
terraform init -backend=false && terraform validate && terraform fmt -check
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
