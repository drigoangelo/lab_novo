<?php
class UsuarioControllerParent {

    protected $request;
    protected $response;
    protected $view;
    protected $viewMethod = 'module';
	protected $gapPerPage = 10;
    
    protected function auth($isOnlyAuthenticated = false){
        $oUtilAuth = new UtilAuth();
        if (!$oUtilAuth->usuarioAutenticado($this->request->get("action"), $isOnlyAuthenticated)){
            $this->view = $oUtilAuth->retornaViewLogin($this->response);
            return false;
        }
        return true;
    }

    public function form(){
        if($this->auth() === FALSE)
            return $this->view;
        return new View(UsuarioAction::getModuleName().'/Usuario.form.php',$this->response, $this->viewMethod);
    }

    public function formSubmit(){
        if($this->auth() === FALSE)
            return $this->view;
        try {
            $oUsuarioAction = new UsuarioAction();
            $oUsuarioAction->validate($this->request);
            $oUsuario = $oUsuarioAction->add($this->request, true, true);
        } catch (Exception $ex) {
            return new View(ExceptionHandler::getMessage($ex),$this->response,'print');
        }
        return new View('OK',$this->response,'print');
    }

    public function admFilter() {
        if($this->auth() === FALSE)
            return $this->view;
        $this->adm();
        return new View(UsuarioAction::getModuleName().'/Usuario.admFilter.php',$this->response, $this->viewMethod);
    }

    public function adm() {
        if($this->auth() === FALSE)
            return $this->view;
        
        $orderSql = ControllerUtil::orderFunction($this->request, $this->response, 'id DESC', $orderPageLinks);
        
        $orderPageConditions = '';
        
        $oUsuarioAction = new UsuarioAction();
        
        $conditions = $oUsuarioAction->filterConditions($this->request, $this->response, $orderPageConditions);
        
        # paginacao
        $fields = $oUsuarioAction->getAdmFields();
        $page = (int) $this->request->get("page") ? (int) $this->request->get("page") : 0;
		$this->gapPerPage = (int) $this->request->get("porPagina") ? (int) $this->request->get("porPagina") : $this->gapPerPage;
        
        $resultsPerPage = ControllerUtil::porPagina($this->request, $this->response, "Usuario");
        
        $conditions = join(" AND ", $conditions);
        $objects = $oUsuarioAction->paginatedCollection($fields, ($page * $resultsPerPage), $resultsPerPage, $conditions, $orderSql, FALSE, $paginator);
        $total = $paginator->count();
        $this->response->set("orderPageConditions", $orderPageConditions);
        $this->response->set("orderPageLinks", $orderPageLinks);
        $this->response->set("objects", $objects);
        $this->response->set("total", $total);
        $this->response->set("resultsInPage", $resultsPerPage);
        $this->response->set("paginationLinks", Paging::getPageLinks(UsuarioAction::getModuleName(), "Usuario","admFilter", $total, $this->gapPerPage, $page, "{$orderPageConditions}{$orderPageLinks}", $this->request->get("porPagina")));
        $this->response->set("perPageLinks", Paging::quantidadePorPagina(UsuarioAction::getModuleName(), "Usuario","admFilter", $page, "{$orderPageConditions}{$orderPageLinks}", $this->request->get("porPagina")));
        $this->response->set("currentPage", $page);
        return new View(UsuarioAction::getModuleName().'/Usuario.adm.php',$this->response, $this->viewMethod);
    }

    public function view() {
        if($this->auth(true) === FALSE)
            return $this->view;
        $oUsuarioAction = new UsuarioAction();
        $id = (int) $this->request->get("id");
        $o = $oUsuarioAction->select($id);
        if ($o === null){
            if($this->viewMethod == "include"){
                return new View('Nenhum registro encontrado!',$this->response,'print');
            }else{
                return $this->admFilter();
            }
        }
        $this->response->set("object",$o);
        return new View(UsuarioAction::getModuleName().'/Usuario.view.php',$this->response, $this->viewMethod);
    }
    
    public function edit() {
        if($this->auth() === FALSE)
            return $this->view;
        $oUsuarioAction = new UsuarioAction();
        $id = (int) $this->request->get("id");
        $o = $oUsuarioAction->select($id);
        if ($o === null) return $this->admFilter();
        $this->response->set("object",$o);
        return new View(UsuarioAction::getModuleName().'/Usuario.edit.php',$this->response, $this->viewMethod);
    }

    public function editSubmit(){
        if($this->auth() === FALSE)
            return $this->view;
        try {
            $oUsuarioAction = new UsuarioAction();
            $oUsuarioAction->validate($this->request,true);
            $oUsuario = $oUsuarioAction->edit($this->request);
        } catch (Exception $ex) {
            return new View(ExceptionHandler::getMessage($ex),$this->response,'print');
        }
        return new View('OK',$this->response,'print');
    }    

    public function editAtivoSubmit(){
        $oUtilAuth = new UtilAuth();
        if (!$oUtilAuth->usuarioAutenticado($this->request->get("action")))
            return $oUtilAuth->retornaViewLogin($this->response);
        $oUsuarioAction = new UsuarioAction();
        if (!$oUsuarioAction->editAtivo((int) $this->request->get("id")))
            return new View($oUsuarioAction->getMsg(),$this->response,'print');
        return new View('OK',$this->response,'print');
    }

    public function del() {
        if($this->auth() === FALSE)
            return $this->view;
        try {
            $id = (int) $this->request->get("id");
            $oUsuarioAction = new UsuarioAction();
            $oUsuarioAction->validateDel($id);
            $oUsuarioAction->delLogical($id);
        } catch (Exception $ex) {
            return new View(ExceptionHandler::getMessage($ex),$this->response,'print');
        }
        return new View('OK',$this->response,'print');
    }
    
    public function delSelected() {
        if($this->auth() === FALSE)
            return $this->view;
        try {
            $oUsuarioAction = new UsuarioAction();
            $ids = $this->request->get("seleciona");
            if (!$ids){
                throw new Exception(NO_SELECTED_MSG);
            }
            $oUsuarioAction->validateDel($ids, false);
            $oUsuarioAction->delLogicalSelected($ids);
        } catch (Exception $ex) {
            return new View(ExceptionHandler::getMessage($ex),$this->response,'print');
        }
        return new View('OK',$this->response,'print');
    }
    
    public function relPDF(){
        $oUtilAuth = new UtilAuth();
        if (!$oUtilAuth->usuarioAutenticado($this->request->get("action")))
            return $oUtilAuth->retornaViewLogin($this->response);
			
		if($this->request->get("porPagina") === "T"){
			$method_view = "include";
			$this->response->set("porPagina", $this->request->get("porPagina"));
		}else{
			$method_view = "relPdf";
			$this->response->set("orientacao", $this->request->get('orientation') ? $this->request->get('orientation') : "portrait");
		}
        $this->adm();
        return new View(UsuarioAction::getModuleName().'/Usuario.relPdf.php',$this->response, $method_view);
    }
    
    public function relXLS(){
        $oUtilAuth = new UtilAuth();
        if (!$oUtilAuth->usuarioAutenticado($this->request->get("action")))
            return $oUtilAuth->retornaViewLogin($this->response);
        
		$this->adm();
		$objects = $this->response->get("objects");
				
        $aFieldsStructure = UsuarioAction::getFieldsStructure();
		$aFieldsTypeGenial = UsuarioAction::getFieldsTypeGenial();
        $aTableHeader = array();
        foreach ($aFieldsStructure as $k => $aField) {
			$typeGenial = is_array($aFieldsTypeGenial[$aField['fieldName']])?$aFieldsTypeGenial[$aField['fieldName']][0]:$aFieldsTypeGenial[$aField['fieldName']];
			if (!in_array($typeGenial, array("autoinc","file","log_usuario", "log_del", "log_data"))) {
				switch($typeGenial){
					case "suggest": case "obj":
						$aTableHeader[$k] = array("type" => "fk", "title" => $aField["columnDefinition"], "value" => $aFieldsTypeGenial[$aField['fieldName']][1]);
					break;
					case "sim/nao":
						$field_name = ucfirst($aField['fieldName']);
						eval("\$aRetSimNao = ConItemSiteAction::getValuesFor{$field_name}();");						
						$aTableHeader[$k] = array("type" => "sim/nao", "title" => $aField["columnDefinition"], "value" => $aRetSimNao);
					break;
					case "date":
						$aTableHeader[$k] = array("type" => "date", "title" => $aField["columnDefinition"], "value" => "date");
					break;
					default:
						$aTableHeader[$k] = array("type" => null, "title" => $aField["columnDefinition"], "value" => "");
					break;
				}
			}
        }
        Util::relXls($objects, $aTableHeader, "Usuario", "UsuarioAction");

        return new View(null, $this->response, 'specificHeader');
    }

    public function suggest($conditions = array(), $order = 'login') {
        $oUtilAuth = new UtilAuth();
        if (!$oUtilAuth->usuarioAutenticado($this->request->get("action"), true))
            return $oUtilAuth->retornaViewLogin($this->response);
        
        $descValue = preg_replace(array('/\(/', '/\)/'), array('\(', '\)'),  $this->request->get('descValue') );
        $idValue = $this->request->get('idValue');
		$limit = $this->request->get('all') ? NULL : POR_PAGINA;

        $page = (int) $this->request->get("pageSuggest") ? (int) $this->request->get("pageSuggest") : 0;
        
        $oUsuarioAction = new UsuarioAction();
        if ($idValue) {
            $objects = ($o = $oUsuarioAction->select($idValue))? array($o) :false;
        } else {
            if ($descValue) {
                if(count($conditions) <= 0)
                    $conditions[] = "o.login LIKE '%{$descValue}%' ";
            }
            $objects = $oUsuarioAction->paginatedCollection(null, ($page * $limit), $limit, $conditions, $order);
        }        
        return new View( ControllerUtil::objectsToSuggest($oUsuarioAction,$objects, $page, 'getId'), $this->response, 'print');
    }


    
}
?>