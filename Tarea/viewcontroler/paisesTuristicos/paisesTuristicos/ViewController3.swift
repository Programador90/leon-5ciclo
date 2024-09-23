import UIKit
import WebKit

class ViewController3: UIViewController {

    @IBOutlet weak var vistaWeb: WKWebView!

    var destinoSeleccionado: String?
    var paisSeleccionado: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        mostrarImagen()
        habilitarZoom() // Llama a la función para habilitar el zoom
    }

    func mostrarImagen() {
        guard let destino = destinoSeleccionado, let pais = paisSeleccionado else { return }
        
        let nombreImagen = "\(pais.lowercased())_\(destino.lowercased()).jpg"
        
        print("Buscando la imagen: \(nombreImagen)")
        
        guard let direccionRecurso = Bundle.main.path(forResource: nombreImagen, ofType: nil, inDirectory: "IMAGENESJPEG") else {
            print("No se encontró el recurso: \(nombreImagen)")
            return
        }
        
        print("Ruta del recurso: \(direccionRecurso)")
        
        let url = URL(fileURLWithPath: direccionRecurso)
        
        // Cargar la imagen directamente en la WKWebView
        vistaWeb.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
    }


    func habilitarZoom() {
        vistaWeb.scrollView.minimumZoomScale = 1.0 // Escala mínima
        vistaWeb.scrollView.maximumZoomScale = 5.0 // Escala máxima
        vistaWeb.scrollView.delegate = self // Establece el delegado
    }
}

// Extensión para manejar el zoom
extension ViewController3: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scrollView.subviews.first // Permite el zoom en la primera subvista del scrollView
    }
}
