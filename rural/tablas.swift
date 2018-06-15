//
//  tablas.swift
//  rural
//
//  Created by DAVID ANGULO CORCUERA on 5/4/18.
//  Copyright © 2018 DAVID ANGULO CORCUERA. All rights reserved.
//
//-> return
import UIKit
import Firebase
import FirebaseDatabase

class tablas:
UIViewController,UITableViewDelegate,UITableViewDataSource,DataHolderDelegate,UISearchBarDelegate {
    //variable del buscador
    var searchController : UISearchController!
    // en este array estan todos los pueblos y el buscador saca de aqui el que busques.
    var arPerfilesFiltro:[Perfil] = []
    @IBOutlet var btnsalir:UIButton?
    @IBOutlet var tablas:UITableView?
    
   //esta funcion va mostrando los resultados que mas se parecen a tu busqueda.
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // si el searchbar esta vacio se muestran todos los pueblos.
        if searchText.isEmpty{
            self.arPerfilesFiltro = DataHolder.sharedInstance.arCiudades
        }
        // busca los pueblos que empiezan por el texto metido en el buscador.
        else{
            arPerfilesFiltro = DataHolder.sharedInstance.arCiudades.filter { (perfil:Perfil) -> Bool in
                return (perfil.sNombre?.contains(searchText))!
            }
        }
        // recargamos la tabla para que cuando no haya nada escrito en el search bar aparezcan todos los pueblos.
        self.refreshUI()
        
    }
    
    // esta funcion al comenzar refresca la tabla para que se muestren todos los pueblos.
    func updateSearchResults(for searchController: UISearchController) {
        self.refreshUI()
    }
    
    //esta funcion devuelve el numero de perfiles para ver las celdas que necesitamos para crear la tabla.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arPerfilesFiltro.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //creamos la celda dentro de la tabla con su identificador de tipo celdaPrototipo
        let celda = tableView.dequeueReusableCell(withIdentifier: "idCelda") as! celdaPrototiopo
        // guardamos el nombre del pueblo y la provincia en el label creado dentro de la celda, con su identificador.
        celda.lblNombre?.text = self.arPerfilesFiltro[indexPath.row].sNombre
        celda.Label?.text = self.arPerfilesFiltro[indexPath.row].sProvincia
        // preguntamos si la imagen está vacia y si lo está no mostramos y si no lo está se muestra.
        if(!(self.arPerfilesFiltro[indexPath.row].sImagen == nil)){
             celda.mostrarImagen(url:  self.arPerfilesFiltro[indexPath.row].sImagen!)
        }
        return celda
    }
    // al dar a un item guardamos el index en una variable en el dataHolder y realizamos la transicion.
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //obtenemos el indice del elemento que estamos pinchando
        var indexPath = tableView.indexPathForSelectedRow
        DataHolder.sharedInstance.indicePueblo = (indexPath?.row)!
        self.performSegue(withIdentifier: "idselect", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // guardamos los perfiles en el "buscador".
        self.arPerfilesFiltro = DataHolder.sharedInstance.arCiudades
       //implementamos el metodo descargarColeccion para descargar los perfiles de la bbdd.
        DataHolder.sharedInstance.descargarColeccion(delegate: self)
        // vamos guardando los pueblos en el array ciudades y luego llenamos el arrfiltro.
        DataHolder.sharedInstance.firestoreDB?.collection("perfiles").addSnapshotListener() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                DataHolder.sharedInstance.arCiudades = []
                for document in querySnapshot!.documents {
                    let pueblo:Perfil = Perfil()
                    pueblo.sID=document.documentID
                    pueblo.setMap(valores: document.data())
                    DataHolder.sharedInstance.arCiudades.append(pueblo)
                    print("\(document.documentID) => \(document.data())")
                }
                self.arPerfilesFiltro = DataHolder.sharedInstance.arCiudades
                self.refreshUI()
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // comprobacion de que los datos se han descargado correctamente.
    func DHDdescargaCiudades(blFin: Bool) {
        if(blFin)
        {
             self.refreshUI()
        }
    
    }
   
    func refreshUI () {
        DispatchQueue.main.async(execute:{self.tablas?.reloadData()})
    }

}
