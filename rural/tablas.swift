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
    
  
    
    var searchController : UISearchController!
   
    var arPerfilesFiltro:[Perfil] = []
    @IBOutlet var btnsalir:UIButton?
    @IBOutlet var tablas:UITableView?
    let alert:UIAlertController = UIAlertController(title: "Has pulsado la tabla", message:  "¡Has pulsado!", preferredStyle: UIAlertControllerStyle.actionSheet)
    
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("////////// OCULTA TECLADO!!!!")
        searchBar.resignFirstResponder()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            self.arPerfilesFiltro = DataHolder.sharedInstance.arCiudades
        }
        else{
            arPerfilesFiltro = DataHolder.sharedInstance.arCiudades.filter { (perfil:Perfil) -> Bool in
                print("HEY!!!! ",(perfil.sNombre?.contains(searchText))!)
                return (perfil.sNombre?.contains(searchText))!
            }
        }
        
        self.refreshUI()
        
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        print("***************")
        self.refreshUI()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("skere--->",self.arPerfilesFiltro.count)
        return self.arPerfilesFiltro.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "idCelda") as! celdaPrototiopo
        celda.lblNombre?.text = self.arPerfilesFiltro[indexPath.row].sNombre
        celda.Label?.text = self.arPerfilesFiltro[indexPath.row].sProvincia
        //if(self.arPerfilesFiltro[indexPath.row].sImagen! != nil)
        //{
        print(self.arPerfilesFiltro[indexPath.row].sNombre,"     ",self.arPerfilesFiltro[indexPath.row].sImagen)
        celda.mostrarImagen(url:  self.arPerfilesFiltro[indexPath.row].sImagen!)
        //}
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //getting the index path of selected row
        var indexPath = tableView.indexPathForSelectedRow
        //DataHolder.sharedInstance.arCiudades[(indexPath?.row)!]=DataHolder.sharedInstance.indicePueblo
        //DataHolder.sharedInstance.indicePueblo = indexPath
        //getting the current cell from the index path
        let currentCell = tableView.cellForRow(at: indexPath!)! as UITableViewCell
        //getting the text of that cell
        let currentItem = self.arPerfilesFiltro[(indexPath?.row)!].sNombre
        
        let alertController = UIAlertController(title: "Pulsaste" , message: "Has seleccionado el pueblo : " + currentItem! , preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Cerrar", style: .default, handler: nil)
        DataHolder.sharedInstance.indicePueblo = (indexPath?.row)!
        alertController.addAction(defaultAction)
        
        //present(alertController, animated: true, completion: nil)
        
            self.performSegue(withIdentifier: "idselect", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.searchBar.showsCancelButton = true
        self.arPerfilesFiltro = DataHolder.sharedInstance.arCiudades
       
        DataHolder.sharedInstance.descargarColeccion(delegate: self)
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
    func DHDdescargaCiudades(blFin: Bool) {
        if(blFin)
        {
            print("Me he descargado la tabla")
             self.refreshUI()
        }
    
    }
   
    func refreshUI () {
        DispatchQueue.main.async(execute:{self.tablas?.reloadData()})
    }

}
