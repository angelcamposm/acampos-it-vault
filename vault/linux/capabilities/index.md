---
draft: false
enableToc: true
publish: true
---


Las Capacidades de Linux (Linux Capabilities) representan un mecanismo fundamental dentro de los sistemas operativos basados en Linux para la gestión y el control de privilegios.

Tradicionalmente, la distinción entre un usuario con privilegios de superusuario (root) y un usuario sin privilegios definía el alcance de las acciones que un proceso podía realizar en el sistema. El usuario root, identificado por un UID de 0, poseía la autoridad para ejecutar prácticamente cualquier operación, mientras que los usuarios con UID distinto de cero estaban sujetos a una serie de restricciones. Sin embargo, esta dicotomía a menudo resultaba en la necesidad de otorgar privilegios de superusuario completos a procesos que únicamente requerían de un subconjunto limitado de estos permisos.

Para abordar esta limitación, a partir de la versión 2.2 del kernel de Linux, se introdujo el concepto de Linux Capabilities. Estas capabilities dividen los privilegios tradicionalmente asociados con el superusuario en unidades discretas e independientes, que pueden habilitarse o deshabilitarse de manera individual para cada hilo de un proceso. Esta desagregación de privilegios permite una administración mucho más precisa y granular de los permisos.

La capacidad de otorgar a un proceso únicamente los privilegios específicos que necesita para llevar a cabo su función, sin concederle la totalidad de los poderes del usuario root, es esencial para la aplicación del principio de mínimo privilegio, una práctica de seguridad fundamental. 

> [!Note] 
> 
> Al limitar los permisos de un proceso al mínimo necesario, se reduce significativamente la superficie de ataque en caso de que dicho proceso sea explotado o comprometido.

## Conjuntos de Capabilities

Para comprender completamente el funcionamiento de las capabilities, es crucial conocer los diferentes conjuntos de capabilities asociados a cada proceso. Estos conjuntos definen qué capabilities puede tener, usar y heredar un proceso:

- El conjunto de **Inherited** (**CapInh**) especifica las capabilities que un proceso hijo hereda de su proceso padre durante la ejecución de la llamada al sistema exec(). Este conjunto permite controlar qué privilegios se transfieren a los nuevos programas ejecutados por un proceso.
- El conjunto de **Permitted** (**CapPrm**) define el conjunto de capabilities que un proceso tiene permitido utilizar. Es importante destacar que un proceso solo puede activar en su conjunto efectivo aquellas capabilities que estén presentes en su conjunto permitido.
- El conjunto de **Effective** (**CapEff**) indica las capabilities que están actualmente activas y que el kernel utiliza para realizar las comprobaciones de permisos cuando el proceso intenta ejecutar una acción privilegiada. La distinción entre los conjuntos Permitted y Effective permite a un proceso habilitar o deshabilitar temporalmente ciertas capabilities según sea necesario.
- El **Bounding set** (**CapBnd**) actúa como un límite superior para las capabilities que un proceso puede adquirir. Ninguna capability que no esté presente en el bounding set de un proceso puede añadirse a sus conjuntos Inherited o Permitted, proporcionando una restricción de seguridad fundamental.
- El conjunto de **Ambient** (**CapAmb**) se aplica en escenarios específicos, como la ejecución de ficheros no-setuid que tienen asignadas file capabilities. Este conjunto define las capabilities que se otorgan al proceso en este contexto particular.

## Beneficios

La utilización de Linux Capabilities ofrece una serie de beneficios significativos en comparación con la concesión indiscriminada de privilegios de superusuario.

**Mayor seguridad:**
Limita el alcance de los daños que puede causar un proceso que ejecuta una operación privilegiada, incluso si el proceso es comprometido por una vulnerabilidad.

**Control más preciso:**
Permite otorgar permisos específicos a los procesos, en lugar de otorgarles todos los permisos de root, lo que facilita la gestión de seguridad y las auditorías.

> [!Tip]
>  Las Capacidades de Linux, permiten la aplicación estricta del principio de mínimo privilegio.

## Listado Detallado de Linux Capabilities

La siguiente tabla presenta un listado de las Linux Capabilities disponibles en las versiones recientes del kernel, junto con una descripción concisa de su función. Posteriormente, se proporcionará una descripción más detallada de algunas de estas capabilities, incluyendo sus casos de uso y las llamadas al sistema asociadas.

|Capability Name|Descripción|
|---|---|
|CAP_AUDIT_CONTROL|Permite habilitar y deshabilitar la auditoría del kernel; cambiar las reglas del filtro de auditoría; recuperar el estado y las reglas de filtrado de la auditoría.|
|CAP_AUDIT_READ|Permite leer el registro de auditoría a través de un socket netlink multicast.|
|CAP_AUDIT_WRITE|Permite escribir registros en el log de auditoría del kernel.|
|CAP_BLOCK_SUSPEND|Permite emplear características que pueden bloquear la suspensión del sistema (epoll(7) EPOLLWAKEUP, /proc/sys/wake_lock).|
|CAP_BPF|Permite operaciones BPF privilegiadas; ver bpf(2) y bpf-helpers(7).|
|CAP_CHECKPOINT_RESTORE|Permite realizar operaciones de checkpoint y restore.|
|CAP_CHOWN|Permite cambiar el propietario (UID) y el grupo (GID) de un fichero.|
|CAP_DAC_OVERRIDE|Permite saltarse las comprobaciones de permisos de acceso discrecional (DAC) para lectura, escritura y ejecución de ficheros.|
|CAP_DAC_READ_SEARCH|Permite saltarse las comprobaciones de permisos para leer ficheros y buscar en directorios.|
|CAP_FOWNER|Permite saltarse las comprobaciones de permisos que normalmente requieren que el UID del proceso coincida con el UID del fichero, excluyendo las operaciones cubiertas por CAP_DAC_OVERRIDE y CAP_DAC_READ_SEARCH.|
|CAP_FSETID|Permite no borrar los bits de modo set-user-ID y set-group-ID al modificar un fichero; establecer el bit set-group-ID para un fichero cuyo GID no coincide con el GID del sistema de archivos o cualquiera de los GIDs suplementarios del proceso llamante.|
|CAP_IPC_LOCK|Permite bloquear memoria (mlock(2), mlockall(2), mmap(2) con MAP_LOCKED).|
|CAP_IPC_OWNER|Permite realizar operaciones IPC_SET y IPC_RMID en objetos IPC System V arbitrarios.|
|CAP_KILL|Permite saltarse las comprobaciones de permisos para el envío de señales, incluyendo el uso de la operación ioctl(2) KDSIGACCEPT.|
|CAP_LEASE|Permite establecer leases en ficheros arbitrarios (ver fcntl(2)).|
|CAP_LINUX_IMMUTABLE|Permite establecer los flags FS_APPEND_FL y FS_IMMUTABLE_FL en inodos (ver FS_IOC_SETFLAGS(2const)).|
|CAP_MAC_ADMIN|Permite la configuración o cambios de estado de MAC (Mandatory Access Control).|
|CAP_MAC_OVERRIDE|Permite anular la configuración de MAC.|
|CAP_MKNOD|Permite crear ficheros especiales usando mknod.|
|CAP_NET_ADMIN|Permite realizar diversas operaciones relacionadas con la red, como configurar interfaces, administrar el firewall IP, el enmascaramiento y la contabilidad, modificar tablas de enrutamiento, etc...|
|CAP_NET_BIND_SERVICE|Permite enlazar un socket a puertos privilegiados del dominio de Internet (números de puerto menores de 1024).|
|CAP_NET_BROADCAST|Permite realizar broadcasts de socket y escuchar multicasts..|
|CAP_NET_RAW|Permite usar sockets RAW y PACKET; enlazar a cualquier dirección para proxying transparente.|
|CAP_PERFMON|Permite emplear operaciones privilegiadas de monitorización del rendimiento; ver perf_event_open(2). Añadida en Linux 5.8 para separar la funcionalidad de monitorización del rendimiento de la sobrecargada capability CAP_SYS_ADMIN.|
|CAP_SETFCAP|Permite establecer capabilities arbitrarias en un fichero. Desde Linux 5.12, también se necesita esta capability para mapear el ID de usuario 0 en un nuevo namespace de usuario.|
|CAP_SETGID|Permite realizar manipulaciones arbitrarias de los GIDs de los procesos y la lista de GIDs suplementarios; falsificar el GID al pasar credenciales de socket a través de sockets de dominio UNIX; escribir una asignación de ID de grupo en un namespace de usuario.|
|CAP_SETPCAP|Permite a un proceso otorgar o eliminar cualquier capability del conjunto permitido del llamante a cualquier otro proceso (si no se admiten file capabilities) o añadir cualquier capability del conjunto de límites del hilo llamante a su conjunto heredable; eliminar capabilities del conjunto de límites (vía prctl(2) PR_CAPBSET_DROP); realizar cambios en los flags securebits (si se admiten file capabilities).|
|CAP_SETUID|Permite realizar manipulaciones arbitrarias de los UIDs de los procesos; falsificar el UID al pasar credenciales de socket a través de sockets de dominio UNIX; escribir una asignación de ID de usuario en un namespace de usuario.|
|CAP_SYS_ADMIN|Una capability amplia que abarca muchas tareas de administración del sistema relacionadas con el sistema de archivos, recursos e inspección de procesos.|
|CAP_SYS_BOOT|Permite reiniciar el sistema.|
|CAP_SYS_CHROOT|Permite usar la llamada al sistema chroot(2) para cambiar el directorio raíz.|
|CAP_SYS_MODULE|Permite cargar y descargar módulos del kernel.|
|CAP_SYS_NICE|Permite aumentar la prioridad de otros procesos (nice(2), setpriority(2)) y establecer políticas de programación (sched_setscheduler(2), sched_setparam(2)).|
|CAP_SYS_PACCT|Permite usar acct(2) para activar o desactivar la contabilidad de procesos.|
|CAP_SYS_PTRACE|Permite rastrear procesos usando ptrace(2).|
|CAP_SYS_RAWIO|Permite realizar operaciones de E/S directamente a dispositivos (mmap(2) de /dev/mem, /dev/kmem, /dev/raw*, ioctl(2) con comandos de disco).|
|CAP_SYS_RESOURCE|Permite anular los límites de recursos del sistema.|
|CAP_SYS_TIME|Permite establecer el reloj del sistema (settimeofday(2), stime(2), adjtimex(2)).|
|CAP_SYS_TTY_CONFIG|Permite configurar terminales (ioctl(2) en tty fd).|
|CAP_SYSLOG|Permite realizar operaciones privilegiadas de syslog(2).|
|CAP_WAKE_ALARM|Permite activar alarmas que pueden despertar el sistema.|
|CAP_CHOWN_RESTRICTED|Restringe el cambio de propietario de ficheros. CAP_CHOWN la omite cuando está activo.|


#### Obras citadas

1. Linux capabilities 101 - Linux Audit, fecha de acceso: mayo 14, 2025, [https://linux-audit.com/kernel/capabilities/linux-capabilities-101/](https://linux-audit.com/kernel/capabilities/linux-capabilities-101/)
2. capabilities(7) - Linux manual page - man7.org, fecha de acceso: mayo 14, 2025, [https://man7.org/linux/man-pages/man7/capabilities.7.html](https://man7.org/linux/man-pages/man7/capabilities.7.html)
3. Capabilities | The Hacker Recipes, fecha de acceso: mayo 14, 2025, [https://www.thehacker.recipes/infra/privilege-escalation/unix/capabilities](https://www.thehacker.recipes/infra/privilege-escalation/unix/capabilities)
4. Linux Capabilities - bpfman, fecha de acceso: mayo 14, 2025, [https://bpfman.io/v0.5.6/developer-guide/linux-capabilities/](https://bpfman.io/v0.5.6/developer-guide/linux-capabilities/)
5. An Introduction to Linux Capabilities - Earthly Blog, fecha de acceso: mayo 14, 2025, [https://earthly.dev/blog/intro-to-linux-capabilities/](https://earthly.dev/blog/intro-to-linux-capabilities/)
6. Capabilities | dockerlabs, fecha de acceso: mayo 14, 2025, [https://dockerlabs.collabnix.com/advanced/security/capabilities/](https://dockerlabs.collabnix.com/advanced/security/capabilities/)
7. Linux Capabilities - Industrial Edge Documentation, fecha de acceso: mayo 14, 2025, [https://docs.eu1.edge.siemens.cloud/develop_an_application/developer_guide/industrial_edge_platform/docker_and_security/02_01_03_Linux%20Capabilities.html](https://docs.eu1.edge.siemens.cloud/develop_an_application/developer_guide/industrial_edge_platform/docker_and_security/02_01_03_Linux%20Capabilities.html)
8. How to find out what Linux capabilities a process requires to work? - Stack Overflow, fecha de acceso: mayo 14, 2025, [https://stackoverflow.com/questions/35469038/how-to-find-out-what-linux-capabilities-a-process-requires-to-work](https://stackoverflow.com/questions/35469038/how-to-find-out-what-linux-capabilities-a-process-requires-to-work)
9. Capabilities guide - rocket - Read the Docs, fecha de acceso: mayo 14, 2025, [https://rocket.readthedocs.io/en/latest/Documentation/capabilities-guide/](https://rocket.readthedocs.io/en/latest/Documentation/capabilities-guide/)
10. How Linux Capability Works in 2.6.25, fecha de acceso: mayo 14, 2025, [https://web.ecs.syr.edu/~wedu/seed/Documentation/Linux/How_Linux_Capability_Works.pdf](https://web.ecs.syr.edu/~wedu/seed/Documentation/Linux/How_Linux_Capability_Works.pdf)
