package modelo;

import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import modelo.Permiso;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2018-10-09T14:31:22")
@StaticMetamodel(Ventana.class)
public class Ventana_ { 

    public static volatile SingularAttribute<Ventana, String> descripcion;
    public static volatile SingularAttribute<Ventana, Integer> idVentana;
    public static volatile SingularAttribute<Ventana, Integer> nivel;
    public static volatile SingularAttribute<Ventana, String> nombre;
    public static volatile SingularAttribute<Ventana, Integer> idVentanaSuperior;
    public static volatile ListAttribute<Ventana, Permiso> permisoList;

}