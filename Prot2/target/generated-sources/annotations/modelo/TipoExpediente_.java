package modelo;

import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import modelo.Expediente;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2018-09-12T12:02:55")
@StaticMetamodel(TipoExpediente.class)
public class TipoExpediente_ { 

    public static volatile SingularAttribute<TipoExpediente, String> descripcion;
    public static volatile SingularAttribute<TipoExpediente, Integer> idTipoExpediente;
    public static volatile ListAttribute<TipoExpediente, Expediente> expedienteList;

}