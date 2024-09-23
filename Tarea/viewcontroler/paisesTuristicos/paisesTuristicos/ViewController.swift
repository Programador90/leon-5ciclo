import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tabla: UITableView!

    // Arreglo de contenido para las celdas (países)
    var contenidoCeldas = ["Brasil", "Peru", "Mexico"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Registrar una celda básica si no se usa storyboard
        tabla.register(UITableViewCell.self, forCellReuseIdentifier: "Celda")

        // Asignar el delegado y la fuente de datos a la tabla
        tabla.dataSource = self
        tabla.delegate = self
    }

    // Método que indica el número de filas por sección en la tabla
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contenidoCeldas.count
    }

    // Método que define las celdas de la tabla
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "Celda", for: indexPath)
        celda.textLabel?.text = contenidoCeldas[indexPath.row]
        return celda
    }

    // Método que maneja la selección de una fila
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let paisSeleccionado = contenidoCeldas[indexPath.row]
        self.performSegue(withIdentifier: "pantallaDosSegue", sender: paisSeleccionado)
    }

    // Preparar el valor que se enviará al segundo controlador
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pantallaDosSegue" {
            if let paisRecibido = sender as? String {
                let pantalla2 = segue.destination as! ViewController2
                pantalla2.paisSeleccionado = paisRecibido
            }
        }
    }
}
