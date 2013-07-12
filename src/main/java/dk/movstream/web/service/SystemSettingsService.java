package dk.movstream.web.service;

import dk.movstream.web.service.model.Language;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
/**
 *
 * @author Martin Rohwedder
 * @since 12-07-2013
 * @version 1.0
 */
@Service
public class SystemSettingsService {

    private final String SYSTEM_SETTINGS_FILEPATH = "/configuration/system.properties";
    private final Resource SYSTEM_SETTINGS_FILE = new ClassPathResource(SYSTEM_SETTINGS_FILEPATH);    
    private final Properties SYSTEM_SETTINGS_PROPERTIES = new Properties();
    private final List<Language> LANGUAGES = new ArrayList<Language>();
    private final String LOCAL_DIRECTORY;
    
    private String languageCode = null;
    
    public SystemSettingsService() throws IOException {
        Properties prop = new Properties();
        prop.load(new FileInputStream(SYSTEM_SETTINGS_FILE.getFile()));
        this.languageCode = prop.getProperty("system.default.language");
        this.LOCAL_DIRECTORY = prop.getProperty("system.default.localDirectory");
        
        LANGUAGES.addAll(Arrays.asList(Language.values()));
    }
    
    public void setLanguageCode(String languageCode) {
        this.languageCode = languageCode;
    }
    
    public String getLanguageCode() {
        return this.languageCode;
    }
    
    public String getLocalDirectory() {
        return this.LOCAL_DIRECTORY;
    }
    
    public List<Language> getLanguages() {
        return this.LANGUAGES;
    }
    
    public void saveSystemSettings() throws IOException {
        SYSTEM_SETTINGS_PROPERTIES.setProperty("system.default.language", this.languageCode);
        SYSTEM_SETTINGS_PROPERTIES.setProperty("system.default.localDirectory", this.LOCAL_DIRECTORY);
        SYSTEM_SETTINGS_PROPERTIES.store(new FileOutputStream(SYSTEM_SETTINGS_FILE.getFile()), null);
    }
    
}
