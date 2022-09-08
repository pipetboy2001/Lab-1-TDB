package com.tingesogrupo4.apirestappgrupo4.services;


import com.tingesogrupo4.apirestappgrupo4.models.Institucion;
import com.tingesogrupo4.apirestappgrupo4.repositories.InstitucionRepository;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping(value = "/")
public class InstitucionService {

    private final InstitucionRepository institucionRepository;
    InstitucionService(InstitucionRepository institucionRepository){
        this.institucionRepository = institucionRepository;
    }


    /*
    @GetMapping("/count")
    public String countUsers(){
        int total = userRepository.countUsers();
        return String.format("Tienes en total %d usuarios",total);
    }

    @GetMapping("/getall")
    public List<User> getAllDiploma(){
        System.out.println("Entro aqui a getAll");
        return userRepository.getAllUsers();

    }

    @PostMapping("/update")
    public User updateUser(@RequestBody User user){
        return userRepository.updateUser(user);
    }
*/

    @PostMapping("/instituciones")
    public Institucion createInstitucion(@RequestBody Institucion institucion){
        System.out.println("Intento posting...");
        return institucionRepository.createInstitucion(institucion);
    }
    @GetMapping("/instituciones/{id}")
    public Institucion getInstitucionById(@PathVariable Integer id){
        return institucionRepository.getInstitucionById(id);
    }

    @GetMapping("/instituciones")
    public List<Institucion> getAllInstituciones(){
        return institucionRepository.getAllInstituciones();

    }
    @PutMapping("/instituciones")
    public Institucion updateInstituciones(@RequestBody Institucion institucion){
        return institucionRepository.updateInstitucion(institucion);
    }

}
