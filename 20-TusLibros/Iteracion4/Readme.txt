Workspace:

factory _ InterfaceTestObjectsFactory new.

server _ TusLibrosServerInterface listeningOn: 8080 interactingWith: factory createSystemFacade.

server destroy

TusLibrosServerInterface allInstances.

TusLibrosServerInterface allInstances do: [ :aServer | aServer destroy ].

TusLibrosClientMainWindow open.


Instrucciones:

1) Introducir el código anterior en un workspace si se va a usar una imagen limpia.
2) Hacer "Do it" de la línea "server _ TusLibrosServerInterface listeningOn: 8080 interactingWith: factory createSystemFacade."
Esto abre el server que atenderá pedidos en localhost:8080

3) Hacer "Do it" de la línea "TusLibrosClientMainWindow open."
Esto abre un cliente en una ventana nueva.

4) La nueva ventana pedirá usuario y contraseña, se acepta para acceder rápidamente a testear la interfaz la introduccion de los campos en blanco. Para evitar esto se debe quitar como usuario registrado al usuario y contraseña vacio del servidor.
También se acepta validUser y validUserPassword como combinación de usuario contraseña válida, ambos siendo usuarios distintos. Si se ingresa correctamente alguno de ellos se creara una nueva ventana, caso contrario se desplegará una pequeña ventana de error roja.

5) En la nueva ventana aparecerán dos listas, una de catálogo y otra de los contenidos del carrito ya creado. La misma tendra 3 botones, uno para agregar al carrito, otro para sacar del carrito, y otro para enviar el carrito a checkout. Además habrá un texto de selección de cantidad a transferir o quitar del carrito. Uso erroneo de los botones de agregar o quitar tanto para quitar demasiado del carrito como para agregar una cantidad invalida generan ventanas de error correspondientes. También lo hace el checkout de un carrito vacío.

6) El checkout se realiza con una tarjeta de crédito inicializada en el cliente. Asumimos que el Cliente en el futuro cuando el usuario se conecte cargará de un archivo encriptado la tarjeta de crédito guardada si ya la suministro el usuario para facilitarle no tener que escribirla constantemente, por otro lado asumimos que en el futuro la tarjeta de credito se transmitirá a traves de una conección segura HTTPS como mínimo de manera encriptada.

7) Al hacer checkout, nos aparecerá una ventana nueva con el ticket de nuestra compra suministrado por el servidor. El mismo incluye el nombre del producto y el precio por el que se compro toda la cantidad comprada. Además incluye el total y botones para desconectarse y hacer compras como otro usuario, crear un nuevo carrito con el mismo usuario, y desplegar el historial de compras del usuario en una ventana nueva.