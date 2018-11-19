/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modeloMng;

import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import modelo.Usuario;
import modelo.Expediente;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import modelo.Cliente;
import modelo.FacturaCabecera;
import modelo.Pais;
import modeloMng.exceptions.IllegalOrphanException;
import modeloMng.exceptions.NonexistentEntityException;

/**
 *
 * @author User
 */
public class ClienteJpaController implements Serializable {

    public ClienteJpaController() {
        this.emf = Persistence.createEntityManagerFactory("com.mycompany_Prot2_war_1.0-SNAPSHOTPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

   public void create(Cliente cliente) {
        if (cliente.getExpedienteList() == null) {
            cliente.setExpedienteList(new ArrayList<Expediente>());
        }
        if (cliente.getFacturaCabeceraList() == null) {
            cliente.setFacturaCabeceraList(new ArrayList<FacturaCabecera>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Pais idPais = cliente.getIdPais();
            if (idPais != null) {
                idPais = em.getReference(idPais.getClass(), idPais.getIdPais());
                cliente.setIdPais(idPais);
            }
            Usuario idUsuario = cliente.getIdUsuario();
            if (idUsuario != null) {
                idUsuario = em.getReference(idUsuario.getClass(), idUsuario.getIdUsuario());
                cliente.setIdUsuario(idUsuario);
            }
            List<Expediente> attachedExpedienteList = new ArrayList<Expediente>();
            for (Expediente expedienteListExpedienteToAttach : cliente.getExpedienteList()) {
                expedienteListExpedienteToAttach = em.getReference(expedienteListExpedienteToAttach.getClass(), expedienteListExpedienteToAttach.getIdExpediente());
                attachedExpedienteList.add(expedienteListExpedienteToAttach);
            }
            cliente.setExpedienteList(attachedExpedienteList);
            List<FacturaCabecera> attachedFacturaCabeceraList = new ArrayList<FacturaCabecera>();
            for (FacturaCabecera facturaCabeceraListFacturaCabeceraToAttach : cliente.getFacturaCabeceraList()) {
                facturaCabeceraListFacturaCabeceraToAttach = em.getReference(facturaCabeceraListFacturaCabeceraToAttach.getClass(), facturaCabeceraListFacturaCabeceraToAttach.getIdFactura());
                attachedFacturaCabeceraList.add(facturaCabeceraListFacturaCabeceraToAttach);
            }
            cliente.setFacturaCabeceraList(attachedFacturaCabeceraList);
            em.persist(cliente);
            if (idPais != null) {
                idPais.getClienteList().add(cliente);
                idPais = em.merge(idPais);
            }
            if (idUsuario != null) {
                idUsuario.getClienteList().add(cliente);
                idUsuario = em.merge(idUsuario);
            }
            for (Expediente expedienteListExpediente : cliente.getExpedienteList()) {
                Cliente oldIdClienteOfExpedienteListExpediente = expedienteListExpediente.getIdCliente();
                expedienteListExpediente.setIdCliente(cliente);
                expedienteListExpediente = em.merge(expedienteListExpediente);
                if (oldIdClienteOfExpedienteListExpediente != null) {
                    oldIdClienteOfExpedienteListExpediente.getExpedienteList().remove(expedienteListExpediente);
                    oldIdClienteOfExpedienteListExpediente = em.merge(oldIdClienteOfExpedienteListExpediente);
                }
            }
            for (FacturaCabecera facturaCabeceraListFacturaCabecera : cliente.getFacturaCabeceraList()) {
                Cliente oldIdClienteOfFacturaCabeceraListFacturaCabecera = facturaCabeceraListFacturaCabecera.getIdCliente();
                facturaCabeceraListFacturaCabecera.setIdCliente(cliente);
                facturaCabeceraListFacturaCabecera = em.merge(facturaCabeceraListFacturaCabecera);
                if (oldIdClienteOfFacturaCabeceraListFacturaCabecera != null) {
                    oldIdClienteOfFacturaCabeceraListFacturaCabecera.getFacturaCabeceraList().remove(facturaCabeceraListFacturaCabecera);
                    oldIdClienteOfFacturaCabeceraListFacturaCabecera = em.merge(oldIdClienteOfFacturaCabeceraListFacturaCabecera);
                }
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Cliente cliente) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Cliente persistentCliente = em.find(Cliente.class, cliente.getIdCliente());
            Pais idPaisOld = persistentCliente.getIdPais();
            Pais idPaisNew = cliente.getIdPais();
            Usuario idUsuarioOld = persistentCliente.getIdUsuario();
            Usuario idUsuarioNew = cliente.getIdUsuario();
            List<Expediente> expedienteListOld = persistentCliente.getExpedienteList();
            List<Expediente> expedienteListNew = cliente.getExpedienteList();
            List<FacturaCabecera> facturaCabeceraListOld = persistentCliente.getFacturaCabeceraList();
            List<FacturaCabecera> facturaCabeceraListNew = cliente.getFacturaCabeceraList();
            List<String> illegalOrphanMessages = null;
            for (Expediente expedienteListOldExpediente : expedienteListOld) {
                if (!expedienteListNew.contains(expedienteListOldExpediente)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Expediente " + expedienteListOldExpediente + " since its idCliente field is not nullable.");
                }
            }
            for (FacturaCabecera facturaCabeceraListOldFacturaCabecera : facturaCabeceraListOld) {
                if (!facturaCabeceraListNew.contains(facturaCabeceraListOldFacturaCabecera)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain FacturaCabecera " + facturaCabeceraListOldFacturaCabecera + " since its idCliente field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            if (idPaisNew != null) {
                idPaisNew = em.getReference(idPaisNew.getClass(), idPaisNew.getIdPais());
                cliente.setIdPais(idPaisNew);
            }
            if (idUsuarioNew != null) {
                idUsuarioNew = em.getReference(idUsuarioNew.getClass(), idUsuarioNew.getIdUsuario());
                cliente.setIdUsuario(idUsuarioNew);
            }
            List<Expediente> attachedExpedienteListNew = new ArrayList<Expediente>();
            for (Expediente expedienteListNewExpedienteToAttach : expedienteListNew) {
                expedienteListNewExpedienteToAttach = em.getReference(expedienteListNewExpedienteToAttach.getClass(), expedienteListNewExpedienteToAttach.getIdExpediente());
                attachedExpedienteListNew.add(expedienteListNewExpedienteToAttach);
            }
            expedienteListNew = attachedExpedienteListNew;
            cliente.setExpedienteList(expedienteListNew);
            List<FacturaCabecera> attachedFacturaCabeceraListNew = new ArrayList<FacturaCabecera>();
            for (FacturaCabecera facturaCabeceraListNewFacturaCabeceraToAttach : facturaCabeceraListNew) {
                facturaCabeceraListNewFacturaCabeceraToAttach = em.getReference(facturaCabeceraListNewFacturaCabeceraToAttach.getClass(), facturaCabeceraListNewFacturaCabeceraToAttach.getIdFactura());
                attachedFacturaCabeceraListNew.add(facturaCabeceraListNewFacturaCabeceraToAttach);
            }
            facturaCabeceraListNew = attachedFacturaCabeceraListNew;
            cliente.setFacturaCabeceraList(facturaCabeceraListNew);
            cliente = em.merge(cliente);
            if (idPaisOld != null && !idPaisOld.equals(idPaisNew)) {
                idPaisOld.getClienteList().remove(cliente);
                idPaisOld = em.merge(idPaisOld);
            }
            if (idPaisNew != null && !idPaisNew.equals(idPaisOld)) {
                idPaisNew.getClienteList().add(cliente);
                idPaisNew = em.merge(idPaisNew);
            }
            if (idUsuarioOld != null && !idUsuarioOld.equals(idUsuarioNew)) {
                idUsuarioOld.getClienteList().remove(cliente);
                idUsuarioOld = em.merge(idUsuarioOld);
            }
            if (idUsuarioNew != null && !idUsuarioNew.equals(idUsuarioOld)) {
                idUsuarioNew.getClienteList().add(cliente);
                idUsuarioNew = em.merge(idUsuarioNew);
            }
            for (Expediente expedienteListNewExpediente : expedienteListNew) {
                if (!expedienteListOld.contains(expedienteListNewExpediente)) {
                    Cliente oldIdClienteOfExpedienteListNewExpediente = expedienteListNewExpediente.getIdCliente();
                    expedienteListNewExpediente.setIdCliente(cliente);
                    expedienteListNewExpediente = em.merge(expedienteListNewExpediente);
                    if (oldIdClienteOfExpedienteListNewExpediente != null && !oldIdClienteOfExpedienteListNewExpediente.equals(cliente)) {
                        oldIdClienteOfExpedienteListNewExpediente.getExpedienteList().remove(expedienteListNewExpediente);
                        oldIdClienteOfExpedienteListNewExpediente = em.merge(oldIdClienteOfExpedienteListNewExpediente);
                    }
                }
            }
            for (FacturaCabecera facturaCabeceraListNewFacturaCabecera : facturaCabeceraListNew) {
                if (!facturaCabeceraListOld.contains(facturaCabeceraListNewFacturaCabecera)) {
                    Cliente oldIdClienteOfFacturaCabeceraListNewFacturaCabecera = facturaCabeceraListNewFacturaCabecera.getIdCliente();
                    facturaCabeceraListNewFacturaCabecera.setIdCliente(cliente);
                    facturaCabeceraListNewFacturaCabecera = em.merge(facturaCabeceraListNewFacturaCabecera);
                    if (oldIdClienteOfFacturaCabeceraListNewFacturaCabecera != null && !oldIdClienteOfFacturaCabeceraListNewFacturaCabecera.equals(cliente)) {
                        oldIdClienteOfFacturaCabeceraListNewFacturaCabecera.getFacturaCabeceraList().remove(facturaCabeceraListNewFacturaCabecera);
                        oldIdClienteOfFacturaCabeceraListNewFacturaCabecera = em.merge(oldIdClienteOfFacturaCabeceraListNewFacturaCabecera);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = cliente.getIdCliente();
                if (findCliente(id) == null) {
                    throw new NonexistentEntityException("The cliente with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(Integer id) throws IllegalOrphanException, NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Cliente cliente;
            try {
                cliente = em.getReference(Cliente.class, id);
                cliente.getIdCliente();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The cliente with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            List<Expediente> expedienteListOrphanCheck = cliente.getExpedienteList();
            for (Expediente expedienteListOrphanCheckExpediente : expedienteListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Cliente (" + cliente + ") cannot be destroyed since the Expediente " + expedienteListOrphanCheckExpediente + " in its expedienteList field has a non-nullable idCliente field.");
            }
            List<FacturaCabecera> facturaCabeceraListOrphanCheck = cliente.getFacturaCabeceraList();
            for (FacturaCabecera facturaCabeceraListOrphanCheckFacturaCabecera : facturaCabeceraListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Cliente (" + cliente + ") cannot be destroyed since the FacturaCabecera " + facturaCabeceraListOrphanCheckFacturaCabecera + " in its facturaCabeceraList field has a non-nullable idCliente field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            Pais idPais = cliente.getIdPais();
            if (idPais != null) {
                idPais.getClienteList().remove(cliente);
                idPais = em.merge(idPais);
            }
            Usuario idUsuario = cliente.getIdUsuario();
            if (idUsuario != null) {
                idUsuario.getClienteList().remove(cliente);
                idUsuario = em.merge(idUsuario);
            }
            em.remove(cliente);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Cliente> findClienteEntities() {
        return findClienteEntities(true, -1, -1);
    }

    public List<Cliente> findClienteEntities(int maxResults, int firstResult) {
        return findClienteEntities(false, maxResults, firstResult);
    }

    private List<Cliente> findClienteEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Cliente.class));
            Query q = em.createQuery(cq);
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public Cliente findCliente(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Cliente.class, id);
        } finally {
            em.close();
        }
    }

    public int getClienteCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Cliente> rt = cq.from(Cliente.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
     /*Responde si existe una duplicacion de la cedula del cliente 
    
      Si idCliente es nulo:(GUARDAR)
        Considera si la cedula esta o no duplicado
    
      Si idCliente no es nulo:(EDITAR)
        Considera si la cedula esta o no duplicado
        pero sin considerar la cedula del clente  identificado por idCliente
    */
    public Boolean existeCiDuplicado(Integer ci, Integer idCliente) {
       
       EntityManager em = getEntityManager();
       
        try {
            String consulta =   "select count(c) from Cliente c "+
                                "where c.ci= :ci";
                    
            if(idCliente != null){
                consulta+= " and c.idCliente != :idCliente"; 
            }
            Query q = em.createQuery(consulta);
            
            q.setParameter("ci", ci);
           
            
            if(idCliente != null){
                 q.setParameter("idCliente", idCliente);
            }
             
            Integer cant = ((Long) q.getSingleResult()).intValue();
            System.out.println(cant+ " cantidad");
            
            if(cant>0){
                return  true;
            }else{
                return false;
            }
            
        } catch(Exception e){
            System.out.println(e);
            return null;
            
        }finally {
            em.close();
        }
    }
    
    /*Responde si existe una duplicacion de la ruc del cliente 
    
      Si idCliente es nulo:(GUARDAR)
        Considera si el ruc  esta o no duplicado
    
      Si idCliente no es nulo:(EDITAR)
        Considera si el ruc esta o no duplicado
        pero sin considerar el ruc del cliente  identificado por idCliente
    */
    public Boolean existeRucDuplicado(String ruc, Integer idCliente) {
       
       EntityManager em = getEntityManager();
       
        try {
            String consulta =   "select count(c) from Cliente c "+
                                "where c.ruc= :ruc";
                    
            if(idCliente != null){
                consulta+= " and c.idCliente != :idCliente"; 
            }
            Query q = em.createQuery(consulta);
            
            q.setParameter("ruc", ruc);
           
            
            if(idCliente != null){
                 q.setParameter("idCliente", idCliente);
            }
             
            Integer cant = ((Long) q.getSingleResult()).intValue();
            System.out.println(cant+ " cantidad");
            
            if(cant>0){
                return  true;
            }else{
                return false;
            }
            
        } catch(Exception e){
            System.out.println(e);
            return null;
            
        }finally {
            em.close();
        }
    }
    
    /**
     * Retorna una lista de clientes que no tengan cuenta de usuario
     * y que tengan estado activo
     * @return List<Cliente>
     */
    public List<Cliente> getListaClienteActivoSinUsuario() {
        EntityManager em = getEntityManager();
        
        try {
           
            String consulta = "select c from Cliente c where c.idUsuario is null and c.estado like 'ACTIVO' order by coalesce(c.nombre,c.razonSocial)";
            Query q = em.createQuery(consulta); 
            return q.getResultList();
            
        }finally {
            em.close();
        }
    }
    
    /**
     * Retorna la lista de clientes con estado "ACTIVO"
     * @return List<Cliente> 
     */
    public List<Cliente> getListaClienteActivo() {
        EntityManager em = getEntityManager();
        
        try {
           
            String consulta = "select c from Cliente c where c.estado like 'ACTIVO' order by coalesce(c.nombre,c.razonSocial) ";
            Query q = em.createQuery(consulta); 
            return q.getResultList();
            
        }finally {
            em.close();
        }
    }
    
    /**
     * Retorna un true si el cliente es editable, falso caso contrario
     * @param idCliente
     * @return Boolean
     */
    public Boolean esEditable(Integer idCliente) {
       
       EntityManager em = getEntityManager();
       
        try {
            String consulta =   "select e.idCliente.idCliente from Expediente e where e.idCliente.idCliente = :idCliente "+
                                " union "+
                                " select f.idCliente.idCliente from FacturaCabecera f where f.idCliente.idCliente = :idCliente and f.estado = 'Pagado'";
                              
                
            Query q = em.createQuery(consulta);
            
            q.setParameter("idCliente", idCliente);
           
             
            List<Integer> lista = q.getResultList();
           
            if(lista.size() > 0){
                return  false;
            }else{
                return true;
            }
            
        } catch(Exception e){
            
            return false;
            
        }finally {
            em.close();
        }
    }
    
     public List<Cliente> getClientePorRuc(String ruc) {
        EntityManager em = getEntityManager();
        
        try {
            String consulta = "select c from Cliente c where c.ruc = :ruc and c.estado = 'ACTIVO' order by coalesce(c.nombre,c.razonSocial)";
            Query q = em.createQuery(consulta); 
            q.setParameter("ruc", ruc);
            return q.getResultList();
         
        }finally {
            em.close();
        }
    }
     
     /**
     * Retorna la lista de clientes ordenados por nombre y razon social
     * @return List<Cliente> 
     */
    public List<Cliente> getListaClienteOrdenados() {
        EntityManager em = getEntityManager();
        
        try {
           
            String consulta = "select c from Cliente c  order by coalesce(c.nombre,c.razonSocial) ";
            Query q = em.createQuery(consulta); 
            return q.getResultList();
            
        }finally {
            em.close();
        }
    }
}
