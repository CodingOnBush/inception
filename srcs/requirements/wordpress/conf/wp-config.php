<?php
// ** Paramètres de la base de données ** //
define('DB_NAME', getenv('MYSQL_DATABASE'));     // Nom de la base de données
define('DB_USER', getenv('MYSQL_USER'));         // Nom d'utilisateur de la base
define('DB_PASSWORD', getenv('MYSQL_PASSWORD')); // Mot de passe de la base
define('DB_HOST', 'mariadb');                    // Adresse de l'hôte (nom du conteneur MariaDB)

// Jeu de caractères à utiliser pour la base de données
define('DB_CHARSET', 'utf8');

// Type de collation de la base de données. Ne changez pas si vous n'êtes pas sûr.
define('DB_COLLATE', '');

// ** Clés et sels uniques d'authentification ** //
define('AUTH_KEY',         'your_random_key_1');
define('SECURE_AUTH_KEY',  'your_random_key_2');
define('LOGGED_IN_KEY',    'your_random_key_3');
define('NONCE_KEY',        'your_random_key_4');
define('AUTH_SALT',        'your_random_key_5');
define('SECURE_AUTH_SALT', 'your_random_key_6');
define('LOGGED_IN_SALT',   'your_random_key_7');
define('NONCE_SALT',       'your_random_key_8');

// Vous pouvez générer ces clés automatiquement sur https://api.wordpress.org/secret-key/1.1/salt/

// Préfixe des tables de la base de données
$table_prefix = 'wp_';

// Activer/désactiver le mode débogage
define('WP_DEBUG', false);

// ** Réglages avancés ** //
// Définir l'URL du site
define('WP_HOME', 'https://yourdomain.com');     // Remplacez par votre domaine
define('WP_SITEURL', 'https://yourdomain.com');

// Répertoires pour les fichiers WordPress
define('WP_CONTENT_DIR', '/var/www/html/wp-content');

// Définit si les fichiers doivent être corrigés dans un environnement en lecture seule
define('FS_METHOD', 'direct');

// Chemin absolu vers le dossier WordPress
if ( !defined('ABSPATH') )
    define('ABSPATH', dirname(__FILE__) . '/');

// Inclure les fichiers WordPress
require_once(ABSPATH . 'wp-settings.php');
