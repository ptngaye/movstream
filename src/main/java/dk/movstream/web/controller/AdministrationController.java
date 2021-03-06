package dk.movstream.web.controller;

import dk.movstream.web.security.SecurityContextSupport;
import dk.movstream.web.service.GenreService;
import dk.movstream.web.service.MovieService;
import dk.movstream.web.service.SeasonService;
import dk.movstream.web.service.SystemSettingsService;
import dk.movstream.web.service.UserService;
import dk.movstream.web.service.model.UserRoleListModel;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
/**
 *
 * @author Martin Rohwedder
 * @since 29-04-2013
 * @version 1.0
 */
@Controller
@RequestMapping(value = {"/admin"})
public class AdministrationController {

    @Autowired
    private MovieService movieService;
    @Autowired
    private UserService userService;
    @Autowired
    private GenreService genreService;
    @Autowired
    private SeasonService seasonService;
    @Autowired
    private SystemSettingsService systemSettingsService;
    
    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView renderAdminHome() {
        ModelAndView mav = new ModelAndView("adminhome");
        
        mav.addObject("navGenres", genreService.getAllMovieGenresWithMovies());
        mav.addObject("moviePercentageBasedOnGenresMap", genreService.moviePercentageBasedOnGenres());
        
        return mav;
    }
    
    @RequestMapping(value = {"/movie"}, method = RequestMethod.GET)
    public ModelAndView renderManageMovie() {
        ModelAndView mav = new ModelAndView("adminmanagemovie");
        
        mav.addObject("movies", movieService.getAllMoviesOrderedById());
        mav.addObject("navGenres", genreService.getAllMovieGenresWithMovies());
        
        return mav;
    }
    
    @RequestMapping(value = {"/movie/delete"}, method = RequestMethod.GET)
    public String deleteMovieAction(@RequestParam(value = "deleteMovieId", required = true) Long id) {
        this.movieService.deleteMovie(id);
        return "redirect:/admin/movie?deleted=1";
    }
    
    @RequestMapping(value = {"/user"}, method = RequestMethod.GET)
    public ModelAndView renderManageUser() {
        ModelAndView mav = new ModelAndView("adminmanageuser");
        
        mav.addObject("navGenres", genreService.getAllMovieGenresWithMovies());
        mav.addObject("users", userService.getAllUsers());
        
        UserRoleListModel userRoleListModel = new UserRoleListModel();
        userRoleListModel.addUserRole("ROLE_SUPERADMIN", "Super Administrator");
        userRoleListModel.addUserRole("ROLE_TEST", "Test");
        mav.addObject("userRoleListModel", userRoleListModel);
        
        return mav;
    }
    
    @RequestMapping(value = {"/user/delete"}, method = RequestMethod.GET)
    public String deleteUserAction(@RequestParam(value = "deleteUserId", required = true) Long id) {
        if (id == 1) {
            return "redirect:/admin/user?deleted=0";
        }
        else if (SecurityContextSupport.getUserDetails().getUser().getId() == id) {
            return "redirect:/admin/user?deleted=2";
        }
        else {
            this.userService.deleteUser(id);
            return "redirect:/admin/user?deleted=1";
        }
    }
    
    @RequestMapping(value = {"/user/reset"}, method = RequestMethod.GET)
    public String resetUserPassword(@RequestParam(value = "resetPasswordUserId", required = true) Long id) {
        if (id == 1) {
            return "redirect:/admin/user?passwordReseted=0";
        }
        else {
            userService.resetUserPassword(userService.getUserById(id));
            return "redirect:/admin/user?passwordReseted=1";
        }
    }
    
    @RequestMapping(value = {"/genre"}, method = RequestMethod.GET)
    public ModelAndView renderManageGenre() {
        ModelAndView mav = new ModelAndView("adminmanagegenre");
        
        mav.addObject("navGenres", genreService.getAllMovieGenresWithMovies());
        mav.addObject("genres", genreService.getAllMovieGenres());
        
        return mav;
    }
    
    @RequestMapping(value = {"/genre/delete"}, method = RequestMethod.GET)
    public String deleteGenreAction(@RequestParam(value = "deleteGenreId", required = true) Long id) {
        genreService.deleteMovieGenre(id);
        return "redirect:/admin/genre?deleted=0";
    }
    
    @RequestMapping(value = {"/season"}, method = RequestMethod.GET)
    public ModelAndView renderManageSeason() {
        ModelAndView mav = new ModelAndView("adminmanageseason");
        
        mav.addObject("navGenres", genreService.getAllMovieGenresWithMovies());
        mav.addObject("seasons", seasonService.getAllSeasons());
        
        return mav;
    }
    
    @RequestMapping(value = {"/season/delete"}, method = RequestMethod.GET)
    public String deleteSeasonAction(@RequestParam(value = "deleteSeasonId", required = true) Long id) {
        seasonService.deleteSeason(id);
        return "redirect:/admin/season?deleted=0";
    }
    
    @RequestMapping(value = {"/settings"}, method = RequestMethod.GET)
    public ModelAndView renderManageSettings() {
        ModelAndView mav = new ModelAndView("adminmanagesettings");
        
        mav.addObject("navGenres", genreService.getAllMovieGenresWithMovies());
        mav.addObject("applicationtitle", systemSettingsService.getApplicationTitle());
        mav.addObject("languages", systemSettingsService.getLanguages());
        mav.addObject("currentLanguageCode", systemSettingsService.getLanguageCode());
        mav.addObject("localDirectory", systemSettingsService.getLocalDirectory());
        mav.addObject("externalLocations", systemSettingsService.getExternalLocations());
        
        return mav;
    }
    
    @RequestMapping(value = {"/settings"}, method = RequestMethod.POST)
    public String saveSettingsAction(HttpServletRequest request, @RequestParam(value = "languageCode", required = true) String lang, @RequestParam(value = "applicationtitle", required = true) String applicationTitle, @RequestParam(value = "externalLocations", required = true) String externalLocations)
            throws IOException {
        HttpSession session = request.getSession();
        
        systemSettingsService.setApplicationTitle(applicationTitle);
        systemSettingsService.setLanguageCode(lang);
        systemSettingsService.setExternalLocations(externalLocations);
        systemSettingsService.saveSystemSettings();
        session.setAttribute("applicationTitle", systemSettingsService.getApplicationTitle());
        return "redirect:/admin/settings?settingsSaved=0";
    }
    
}
