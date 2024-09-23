import UIKit

class ViewController2: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tablaDestinos: UITableView!

    var paisSeleccionado: String?
    var destinos: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configurarDestinos()
        
        // Registrar la celda si es necesario
        tablaDestinos.register(UITableViewCell.self, forCellReuseIdentifier: "CeldaDestino")
        
        tablaDestinos.dataSource = self
        tablaDestinos.delegate = self
    }

    func configurarDestinos() {
        guard let pais = paisSeleccionado else { return }

        switch pais {
        case "Brasil":
            destinos = ["Rio de Janeiro", "Sao Paulo", "Brasilia"]
        case "Peru":
            destinos = ["Piura", "Tacna", "Ucayali"]
        case "Mexico":
            destinos = ["Cancun", "Ciudad de Mexico", "Guadalajara"]
        default:
            destinos = []
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return destinos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "CeldaDestino", for: indexPath)
        celda.textLabel?.text = destinos[indexPath.row]
        return celda
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinoSeleccionado = destinos[indexPath.row]
        self.performSegue(withIdentifier: "mostrarImagenSegue", sender: destinoSeleccionado)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mostrarImagenSegue" {
            if let destinoRecibido = sender as? String {
                let pantalla3 = segue.destination as! ViewController3
                pantalla3.destinoSeleccionado = destinoRecibido
                pantalla3.paisSeleccionado = paisSeleccionado
            }
        }
    }
}
