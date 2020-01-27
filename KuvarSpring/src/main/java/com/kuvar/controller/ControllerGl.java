package com.kuvar.controller;

import java.io.InputStream;
import java.io.OutputStream;
import java.security.Principal;
import java.sql.SQLIntegrityConstraintViolationException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kuvar.repository.CategoryRepository;
import com.kuvar.repository.ContainsRepository;
import com.kuvar.repository.FavCategoryRepository;
import com.kuvar.repository.IngredientRepository;
import com.kuvar.repository.IsFriendRepository;
import com.kuvar.repository.MessageRepository;
import com.kuvar.repository.PictureRepository;
import com.kuvar.repository.ReceiptRepository;
import com.kuvar.repository.RoleRepository;
import com.kuvar.repository.UserRepository;

import model.Category;
import model.Contain;
import model.Favourite_category;
import model.Ingredient;
import model.IsFriend;
import model.Message;
import model.Picture;
import model.Recipe;
import model.Role;
import model.User;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

@Controller
@RequestMapping("/controller")
public class ControllerGl {
	@Autowired
	UserRepository ur;
	@Autowired
	RoleRepository rr;
	@Autowired
	CategoryRepository cr;
	@Autowired
	IngredientRepository ir;
	@Autowired
	ReceiptRepository recr;
	@Autowired
	ContainsRepository contr;
	@Autowired
	FavCategoryRepository fcr;
	@Autowired
	PictureRepository picr;
	@Autowired
	IsFriendRepository isfr;
	@Autowired
	MessageRepository mr;

	@RequestMapping(value = "newUser", method = RequestMethod.POST)
	public String newUser(User u) {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		u.setPassword(passwordEncoder.encode(u.getPassword()));
		if (ur.findAll().size() == 0) {
			Role role = new Role();
			role.setName("user");
			rr.save(role);
			Role admin = new Role();
			admin.setName("admin");
			rr.save(admin);

			u.setRole(admin);
		} else {
			u.setRole(rr.findByName("user"));
		}

		ur.save(u);
		return "login";
	}

	@RequestMapping(value = "/admin/addCat", method = RequestMethod.POST)
	public String addKategory(HttpServletRequest request, String name) {
		if (name != null) {
			Category c = new Category();

			c.setName(name.toLowerCase());
			cr.save(c);
			request.getSession().setAttribute("novaKat", c);
		}
		return "admin/addCategory";
	}

	@RequestMapping(value = "/users/addFavC", method = RequestMethod.POST)
	public String addFavKategory(HttpServletRequest request, String name, Principal principal) {
		if (name != null) {
			Favourite_category c = new Favourite_category();
			c.setName(name);
			User u = ur.findByUsername(principal.getName());
			c.setUser(u);
			fcr.save(c);
			u.addFavouriteCategory(c);
			ur.flush();

			request.getSession().setAttribute("novaKatFav", c);
		}
		return "users/addFavCat";
	}

	@RequestMapping(value = "users/fwdAddRecipe", method = RequestMethod.GET)
	public String fwdAddRecipe(HttpServletRequest request, String name, Principal principal) {
		List<Category> kategorije = cr.findAll();
		request.getSession().setAttribute("kategorije", kategorije);
		return "users/addRecipes";
	}

	@RequestMapping(value = "users/addRecipe", method = RequestMethod.POST)
	public String addRecipe(HttpServletRequest request, String description, int idKat, String name,
			Principal principal) {
		if (name != null && description != null) {
			Recipe r = new Recipe();
			Category cat = cr.getOne(idKat);
			r.setCategory(cat);
			r.setDescription(description);
			r.setUser(ur.findByUsername(principal.getName()));
			r.setName(name);
			r.setDate(new Date());

			recr.save(r);

			cat.addRecipe(r);
			cr.flush();

			recr.flush();
			request.getSession().setAttribute("recept", r);
		}
		return "users/addRecipes";
	}

	@RequestMapping(value = "users/addIngredient", method = RequestMethod.POST)
	public String addIngd(HttpServletRequest request, String name, String amount, Principal principal) {
		Recipe r = (Recipe) request.getSession().getAttribute("recept");
		if (r != null) {
			Ingredient i = ir.findByName(name.toLowerCase());
			if (i == null) {
				i = new Ingredient();
				i.setName(name.toLowerCase());
			}

			ir.save(i);
			Contain c = new Contain();
			c.setAmount(amount);
			c.setRecipe(r);
			c.setIngredient(i);
			contr.save(c);
			r.addContain(c);
			i.addContain(c);

			ir.flush();
			contr.flush();
			recr.flush();
		}
		return "users/addIngr";
	}

	@RequestMapping(value = "users/addPic", method = RequestMethod.POST)
	public String addPic(HttpServletRequest request, String path, Principal principal) {
		Recipe r = (Recipe) request.getSession().getAttribute("recept");
		if (r != null && path != null) {
			Picture p = new Picture();
			p.setPath(path);
			p.setRecipe(r);
			r.addPicture(p);

			picr.save(p);

			ir.flush();
			contr.flush();
			recr.flush();
			request.getSession().setAttribute("recept", r);
		}
		return "users/addPics";
	}

	@RequestMapping(value = "search", method = RequestMethod.GET)
	public String prikaz(HttpServletRequest request) {
		request.getSession().removeAttribute("kategorijeSearch");
		request.getSession().removeAttribute("contains");

		List<Category> kategorije = cr.findAll();
		List<Ingredient> ingredients = ir.findAll();

		request.getSession().setAttribute("kategorije", kategorije);
		request.getSession().setAttribute("ingredients", ingredients);
		return "searching";
	}

	@RequestMapping(value = "searchCategory", method = RequestMethod.GET)
	public String prikazKategorija(HttpServletRequest request, int idKat, Principal pr) {
		request.getSession().removeAttribute("contains");

		Category cat = cr.getOne(idKat);

		List<Recipe> kategorije = cat.getRecipes();
		request.getSession().setAttribute("kategorijeSearch", kategorije);

		if (pr != null) {
			User u = ur.findByUsername(pr.getName());
			List<Favourite_category> omiljeneCR = u.getFavouriteCategories();
			request.getSession().setAttribute("omiljeneCR", omiljeneCR);
		}

		return "searching";
	}

	@RequestMapping(value = "searchIngredient", method = RequestMethod.GET)
	public String prikazIngredient(HttpServletRequest request, int idI, Principal pr) {
		request.getSession().removeAttribute("kategorijeSearch");

		Ingredient i = ir.getOne(idI);

		List<Contain> contains = i.getContains();
		System.out.println(contains.size());
		request.getSession().setAttribute("contains", contains);

		if (pr != null) {
			User u = ur.findByUsername(pr.getName());
			List<Favourite_category> omiljeneCR = u.getFavouriteCategories();
			request.getSession().setAttribute("omiljeneCR", omiljeneCR);
		}
		return "searching";
	}

	@RequestMapping(value = "showRecept", method = RequestMethod.GET)
	public String showRecept(HttpServletRequest request, int idR) {
		request.getSession().setAttribute("rec", recr.getOne(idR));
		return "vidiRecept";
	}

	@RequestMapping(value = "/users/profile", method = RequestMethod.GET)
	public String profile(HttpServletRequest request, Principal principal) {
		String name = principal.getName();

		User u = ur.findByUsername(name);
		request.getSession().setAttribute("user", u);

		List<User> svi = ur.findAllNotFriends(u.getIdUser());
		List<User> prijatelji = new ArrayList<User>();// PRIJATELJI
		List<IsFriend> veze = u.getIsFriends2();
		for (IsFriend prr : veze) {
			prijatelji.add(prr.getUser1());
		}
		request.getSession().setAttribute("prijatelji", prijatelji);
		List<Favourite_category> omiljene = u.getFavouriteCategories();
		request.getSession().setAttribute("omiljene", omiljene);
		request.getSession().setAttribute("svi", svi);
		return "users/profil";

	}

	@RequestMapping(value = "allRecepts", method = RequestMethod.GET)
	public String allRecepts(HttpServletRequest request, Principal pr) {
		List<Recipe> recepti = recr.findAll();

		request.getSession().setAttribute("recepti", recepti);

		if (pr != null) {
			User u = ur.findByUsername(pr.getName());
			List<Favourite_category> omiljeneCR = u.getFavouriteCategories();
			request.getSession().setAttribute("omiljeneCR", omiljeneCR);
		}
		return "receptio";
	}

	@RequestMapping(value = "/users/myRecipes", method = RequestMethod.GET)
	public String myRecepts(HttpServletRequest request, Principal pr) {
		List<Recipe> recepti = ur.findByUsername(pr.getName()).getRecipes();

		request.getSession().setAttribute("moji", recepti);
		User u = ur.findByUsername(pr.getName());
		List<Favourite_category> omiljeneCR = u.getFavouriteCategories();
		request.getSession().setAttribute("omiljeneCR", omiljeneCR);
		return "users/profileMyRecipes";
	}

	@RequestMapping(value = "/users/addFriend", method = RequestMethod.GET)
	public String dodajPrijatelja(HttpServletRequest request, Principal principal, int idP) {

		User ja = ur.findByUsername(principal.getName());
		User ti = ur.getOne(idP);

		IsFriend prij = new IsFriend();
		prij.setStatus("yes");
		prij.setUser1(ti);
		prij.setUser2(ja);
		IsFriend prij2 = new IsFriend();
		prij2.setStatus("yes");
		prij2.setUser1(ja);
		prij2.setUser2(ti);
		isfr.save(prij);
		isfr.save(prij2);

		ja.addIsFriends1(prij);
		ja.addIsFriends2(prij2);

		ti.addIsFriends1(prij2);
		ti.addIsFriends2(prij);
		ur.flush();

		profile(request, principal);

		return "users/profil";

	}

	@RequestMapping(value = "users/sendMessages", method = RequestMethod.GET)
	public String poruka(HttpServletRequest request, int idUser, Principal pr) {
		User user1 = ur.findByUsername(pr.getName());
		System.out.println(user1.getName());
		request.getSession().setAttribute("user", user1);
		User user2 = ur.getOne(idUser);
		request.getSession().setAttribute("user2", user2);
		System.out.println(user2.getName());
		User novi = (User) request.getSession().getAttribute("user2");
		System.out.println(novi);
		List<Message> poruke = mr.getAllMessagesForUsers(user1.getIdUser(), user2.getIdUser());
		request.getSession().setAttribute("poruke", poruke);
		return "users/messages";
	}

	@RequestMapping(value = "/users/sent", method = RequestMethod.POST)
	public String poslato(HttpServletRequest request, String content, Principal pr) {
		User user2 = (User) request.getSession().getAttribute("user2");
		System.out.println(user2.getName());
		User user1 = ur.findByUsername(pr.getName());
		Message m = new Message();
		m.setContent(content);
		m.setDate(new Date());
		m.setUser1(user1);
		m.setUser2(user2);

		mr.save(m);

		List<Message> poruke = mr.getAllMessagesForUsers(user1.getIdUser(), user2.getIdUser());

		request.getSession().setAttribute("poruke", poruke);
		request.getSession().setAttribute("user", user1);
		request.getSession().setAttribute("user2", user2);
		return "users/messages";
	}

	@RequestMapping(value = "/users/addReceptToCategory", method = RequestMethod.POST)
	public String dodajUomiljene(HttpServletRequest request, int idFavKat, int idR) {
		try {
		Recipe r = recr.getOne(idR);
		Favourite_category fc = fcr.findById(idFavKat).orElse(null);
		
			fc.addRecipe(r);
			r.addToFavCategory(fc);
			// r.setFavouriteCategories();
			fc.getRecipes().stream().forEach(System.out::println);
		
		recr.flush();
		fcr.save(fc);
		ur.flush();
		} catch (Exception ex) {
			
		}
		return "receptio";
		
	}

	@RequestMapping(value = "/admin/statistics", method = RequestMethod.GET)
	public String stats(HttpServletRequest request) {
		List<Category> cat = cr.findAll();

		request.getSession().setAttribute("cat", cat);
		return "admin/stats";
	}
	 @RequestMapping(value="admin/generateReportCat", method=RequestMethod.POST)
	 public void izvestaj(HttpServletResponse response) throws Exception{
	 	List<Recipe> sve = recr.findAll();
	 	
	 	Collections.sort(sve, new Komparator());
	 	response.setContentType("text/html");
	 	JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(sve);
	 	InputStream inputStream = this.getClass().getResourceAsStream("/jasperreports/reportCat.jrxml");
	 	JasperReport jasperReport = JasperCompileManager.compileReport(inputStream);
	 	Map<String, Object> params = new HashMap<String, Object>();
//	 	params.put("datum", i.getDatum());
//	 	params.put("nazivPredstave", i.getPredstava().getNaziv());
//	 	params.put("nazivScene", i.getScena().getNaziv());
	 	JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, params,dataSource);
	 	inputStream.close();

	 	response.setContentType("application/x-download");
	 	response.addHeader("Content-disposition", "attachment; filename=izvestaj.pdf");
	 	OutputStream out = response.getOutputStream();
	 	JasperExportManager.exportReportToPdfStream(jasperPrint, out);
	 }
	

	@RequestMapping(value = "/admin/datePicker", method = RequestMethod.GET)
	public void date(HttpServletRequest request, HttpServletResponse response, Date date)  {
		//DATE 26.januar, 2020]
		try {
			List<Recipe> svi;
		if (date != null) {
			Date date1 = date;
			int br = recr.getByDate(date1).size();
			svi = recr.getByDate(date1);
			
			request.getSession().setAttribute("datum", date);
			request.getSession().setAttribute("datumBr", br);
		}else {
			svi = recr.findAll();
			Collections.sort(svi, new KomparatorDatum());
		}
		response.setContentType("text/html");
	 	JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(svi);
	 	InputStream inputStream = this.getClass().getResourceAsStream("/jasperreports/poDatumu.jrxml");
	 	JasperReport jasperReport = JasperCompileManager.compileReport(inputStream);
	 	Map<String, Object> params = new HashMap<String, Object>();
//	 	params.put("datum", i.getDatum());
//	 	params.put("nazivPredstave", i.getPredstava().getNaziv());
//	 	params.put("nazivScene", i.getScena().getNaziv());
	 	JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, params,dataSource);
	 	inputStream.close();

	 	response.setContentType("application/x-download");
	 	response.addHeader("Content-disposition", "attachment; filename=DrugiIzvestaj.pdf");
	 	OutputStream out = response.getOutputStream();
	 	JasperExportManager.exportReportToPdfStream(jasperPrint, out);
		}catch(Exception e) {}
		
	}
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		sdf.setLenient(true);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(sdf, true));
	}

}
class Komparator implements Comparator<Recipe>{

	@Override
	public int compare(Recipe o1, Recipe o2) {
		// TODO Auto-generated method stub
		return o1.getCategory().getName().compareTo(o2.getCategory().getName());
	}
	
}
class KomparatorDatum implements Comparator<Recipe>{

	@Override
	public int compare(Recipe o1, Recipe o2) {
		// TODO Auto-generated method stub
		return o1.getDate().compareTo(o2.getDate());
	}
	
}
