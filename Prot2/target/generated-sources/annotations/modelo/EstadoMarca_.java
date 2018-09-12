package modelo;

import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import modelo.Expediente;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2018-09-08T19:25:57")
@StaticMetamodel(EstadoMarca.class)
public class EstadoMarca_ { 

    public static volatile SingularAttribute<EstadoMarca, String> descripcion;
    public static volatile SingularAttribute<EstadoMarca, Integer> idEstado;
    public static volatile ListAttribute<EstadoMarca, Expediente> expedienteList;

}