package modelo;

import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import modelo.Permiso;
import modelo.Usuario;

@Generated(value="EclipseLink-2.5.2.v20140319-rNA", date="2018-10-09T14:31:22")
@StaticMetamodel(Rol.class)
public class Rol_ { 

    public static volatile SingularAttribute<Rol, String> descripcion;
    public static volatile SingularAttribute<Rol, String> estado;
    public static volatile SingularAttribute<Rol, Integer> idRol;
    public static volatile ListAttribute<Rol, Usuario> usuarioList;
    public static volatile ListAttribute<Rol, Permiso> permisoList;
    public static volatile SingularAttribute<Rol, String> rol;

}