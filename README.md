# INFRAESTRUCTURA BASICA EN AWS CREADA CON CODIGO TERRAFORM

## La infraestructura incluye lo siguiente:
- 1 VPC
- 2 Subredes publicas
- 2 Subredes privadas
- 1 Internet gateway
- 3 Tablas de Rutas
- 1 Maquina Virtual (ec2) con sistema operativo Amazon Linux 2
- 1 Grupo de seguridad con permisos para SSH, HTTP y HTTPS.

## Una vez el codigo terraform ha sido clonado y se tengan configuradas la AWS CLI y Terraform se procede:
- Ejecucion de <code>terraform init</code> para descargar los paquetes terraform necesarios.
- Ejecucion de <code>terraform validate</code> para validar que todo esta correcto.
- Ejecucion de <code>terraform apply</code> para desplegar la infraestructura en AWS.
- Ejecucion de <code>terraform destroy</code> para desmontar la infraestructura desplegada en AWS.
 
### Saludos.
