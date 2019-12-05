<!doctype html>
<html>

<head>
    <link rel="stylesheet" href="styles.css">
</head>

<body>
    <?php
    session_start();
    include "lawutils.php";
    
    if (!isset($_SESSION['login']) || $_SESSION['login'] == '')
    {
        echo $_SESSION['login'];
        header ("Location: ./lawlogin.html");
    } 
    
    
    echo "<h2>Lawyer DB Manager</h2>";

    //************//
    
    connectToDB();
    
    ///**********//
    
    $thisPHP = $_SERVER['PHP_SELF'];
    $databaseAction = '';            // No default modification action
    $displayAction = 'showRecords';      // Default display 

    if (isset($_POST['btnInsert']))
        $databaseAction = 'doInsert';
    if (isset($_POST["btnDelete"]))
        $databaseAction = 'doDelete';
    if (isset($_POST["btnEdit:"]))
        $databaseAction = 'doEdit';
    
    if (isset($_POST['showInsertForm']))
        $displayAction = 'showInsertForm';
    else
        $displayAction ='showRecords';

    
    ///*****************//
    // Database Actions
    ///*****************//
    // These two are pre-display database actions.
    // Insertion or Deletion will be done prior to showClientRecords()
    // And thus, showClientRecords() will show updated database
    
    //Insert Action
             
    if ($databaseAction == 'doInsert')
    {
       insertClientRecord();
    }
    
    
    //Delete Action
                  
    else if ($databaseAction == 'doDelete')
    {
        deleteClientRecord();
    }

    
    if ($displayAction == 'showInsertForm')
    {
        
        displayInsertForm();
    }

    // Default action: show always be true since inialized at script start
    // Display table showing all client records
    
    else if ($displayAction == 'showRecords')
    {
        showClientRecords();
    }
    $conn->close();
?>
</body>

</html>
