import UIKit
import WebKit

class ViewController2: UIViewController {

    @IBOutlet weak var vistaWeb: WKWebView! // Asegúrate de que este Outlet esté conectado correctamente.

    var recursoRecibido: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        mostrarRecurso() // Llamar a la función para mostrar el recurso cuando la vista cargue.
        habilitarZoom()  // Llamar a la función para habilitar el zoom.
    }

    func mostrarRecurso() {
        guard let recurso = recursoRecibido else {
            print("recursoRecibido es nulo.")
            return
        }

        // Crear la URL del recurso
        guard let direccionRecurso = Bundle.main.path(forResource: recurso, ofType: "jpeg", inDirectory: "RECURSOS") else {
            print("No se encontró el recurso: \(recurso)")
            return
        }
        
        let url = URL(fileURLWithPath: direccionRecurso)

        // Cargar la imagen en la vista WebView
        let htmlString = "<html><body><img src='\(url.absoluteString)' style='width:100%; height:auto;'/></body></html>"
        vistaWeb.loadHTMLString(htmlString, baseURL: nil)
    }

    func habilitarZoom() {
        vistaWeb.scrollView.minimumZoomScale = 1.0 // Escala mínima
        vistaWeb.scrollView.maximumZoomScale = 5.0 // Escala máxima
        vistaWeb.scrollView.delegate = self // Establece el delegado
    }
}

// Extensión para manejar el zoom
extension ViewController2: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scrollView.subviews.first // Permite el zoom en la primera subvista del scrollView
    }
}
