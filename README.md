### 1. Gateway y Enrutador (`gw`)

* **Hostname:** `gw-sgb`
* **Interfaces de red:**
  * `eth0` (NAT): Vagrant por defecto.
  * `eth1` (Bridge): Conexión puente a la red física del aula.
  * `eth2` (DMZ): `172.1.5.1`
  * `eth3` (Empleados): `172.2.5.1`
  * `eth4` (Gestión): `172.3.5.1`

### 2. LAN de Gestión / Intranet (`172.3.5.0/24`)

Salida a Internet enrutada por el `gw`.

* **Proveedor de Identidades**
  * **Hostname:** `idp-sgb`
  * **IP:** `172.3.5.2`
  * **Rol:** Servidor OpenLDAP.
* **Servidor de Backups (`backup-srv`)**
  * **SO:** Alpine Linux
  * **Hostname:** `backup-srv-sgb`
  * **IP:** `172.3.5.20`
  * **Rol:** Tira (`pull`) de los datos (mediante `rsync` y `cron`) de los demás servidores hacia su almacenamiento local de forma segura.

### 3. LAN de Empleados (`172.2.5.0/24`)

Red de usuarios estándar. Navegación restringida a través del proxy.

* **Equipo de Administración (`adminpc`)**
  * **Hostname:** `adminpc-sgb`
  * **IP:** `172.2.5.10`
  * **Rol:** Máquina de salto y gestión. El administrador despliega scripts, se conecta por SSH a los demás equipos.
* **Equipo Empleado (`empleado`)**
  * **Hostname:** `empleadopc-sgb`
  * **IP:** `172.2.N.100`
  * **Rol:** Simula un empleado de la PYME.

### 4. DMZ - Zona Desmilitarizada (`172.1.5.0/24`)

Servicios expuestos o que intermedian con el exterior.

* **Servidor Proxy (`proxy`)**
  * **Hostname:** `proxy-sgb`
  * **IP:** `172.1.5.2`
  * **Rol:** Proxy web (Squid) para filtrar tráfico de los empleados.
* **Servidor Web (`www`)**
  * **Hostname:** `www-sgb`
  * **IP:** `172.1.5.3`
  * **Rol:** Aloja los servicios web expuestos de la PYME y DVWA.


## 2. Instrucciones para el despliegue

### 2.1. Requisitos previos

Tener instalado lo siguiente:

* Git
* VirtualBox
* Vagrant

### 2.2. Despliegue

1. Clonar este repositorio:

```bash
git clone https://github.com/pes130/SAD-PROYECTO-2026-26-solucion.git
```

2. Levantar con vagrant

```bash
cd SAD-PROYECTO-2026-26-solucion
vagrant up
```

3. Comprobar el estado de las máquinas con:

```bash
vagrant status
```

4. Y accedemos a las máquinas con `vagrant ssh máquina`. Ej. para acceder a www:

```bash
vagrant ssh www
```