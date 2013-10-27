<?php

if(isset($_REQUEST['id']))
$id = $_REQUEST['id'];
	else
$id = 4;
if(isset($_REQUEST['id_usuario']))
$id_usuario = $_REQUEST['id_usuario'];
	else
$id_usuario = 3;
if(isset($_REQUEST['perfil']))
$perfil = $_REQUEST['perfil'];
	else
$perfil = 'Esponja';
if(isset($_REQUEST['foto']))
$foto = $_REQUEST['foto'];
	else
$foto = 'foto.jpg';
if(isset($_REQUEST['categoria']))
$categoria = $_REQUEST['categoria'];
	else
$categoria = 'atravesado';
if(isset($_REQUEST['revisado']))
$revisado = $_REQUEST['revisado'];
	else
$revisado = 1;
if(isset($_REQUEST['observacion']))
$observacion = $_REQUEST['observacion'];
	else
$observacion = 'se atraveso como un perro';
if(isset($_REQUEST['longitud']))
$longitud = $_REQUEST['longitud'];
	else
$longitud = 11.455;
if(isset($_REQUEST['latitud']))
$latitud = $_REQUEST['latitud'];
	else
$latitud = 73.550;

include("data.inc");
      $connection = mysql_connect($host,$user,$password)  
                or die ("Couldn't connect to server.");
      $db = mysql_select_db($database, $connection)
                or die ("Couldn't select database.");

// this insert query defines the table, and columns you want to update
$query = "INSERT INTO casos (id, id_usuario, perfil, foto, categoria, revisado, observacion, longitud, latitud)
VALUES ('$id', '$id_usuario',  '$perfil', '$foto', '$categoria', '$revisado', '$observacion',  '$longitud', '$latitud')";
$result = mysql_query($query) or die ("casi .");

?>