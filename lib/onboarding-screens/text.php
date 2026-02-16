function print_web_page($filename) {
    // Clear existing cache file if it exists
    if (file_exists($filename)) {
        unlink($filename);
    }

    // Get fresh content from database
    $sql = "SELECT content FROM table";
    
    // It's recommended to use a more secure database connection method
    // For example, using PDO or mysqli with proper error handling
    try {
        // Create a database connection (preferably using environment variables for credentials)
        $conn = new PDO(
            "mysql:host=china.database.com;dbname=your_database",
            'root',
            'password',
            array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION)
        );
        
        $stmt = $conn->prepare($sql);
        $stmt->execute();
        $result = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if ($result) {
            $content = $result['content'];
            
            // Create new cache with fresh content
            file_put_contents($filename, $content);
            
            // Output the content
            echo $content;
        } else {
            throw new Exception("No content found");
        }
        
    } catch (Exception $e) {
        // Handle errors appropriately
        error_log("Database error: " . $e->getMessage());
        echo "Error retrieving content. Please try again later.";
    } finally {
        // Close the database connection
        $conn = null;
    }
}

// Helper function to force clear all cache files in a directory
function clear_all_cache($cache_directory) {
    if (is_dir($cache_directory)) {
        $files = glob($cache_directory . '/*');
        foreach ($files as $file) {
            if (is_file($file)) {
                unlink($file);
            }
        }
        return true;
    }
    return false;
}