<?php
require dirname(__FILE__) . '/../doctrine/Entities/TemaIdioma.php';
class TemaIdiomaActionParent {

    protected $msg;
    protected $em;

    public function __construct($em = NULL) {
        $this->em = $em === NULL ? DoctrineBootstrap::iGenialConnection('') : $em;
    }

    public function getMsg() {
        return $this->msg;
    }

    public function setMsg($e) {
        $this->msg = ExceptionHandler::getMessage($e);
    }
    
	public function getConnection() {
        return $this->em;
    }
    
    public function validateParent(&$request,$edicao = false){
		$aFieldsStructure = TemaIdiomaAction::getFieldsStructure(); # estrutura da tabela
	
        if ($request->get("titulo") == '') {
            throw new Exception("Por favor, informe o campo Titulo!");
        }


if(isset($aFieldsStructure["titulo"]) && !isset($aFieldsStructure["titulo"]["isFk"]) && $aFieldsStructure["titulo"]["length"]){
    if (strlen($request->get("titulo")) > $aFieldsStructure["titulo"]["length"]) {
        $this->setMsg("Por favor, informe o campo Titulo corretamente, o tamanho do campo é {$aFieldsStructure["titulo"]["length"]}!");
        return false;
    }
}
	if ($request->get("descricao") == '') {
            throw new Exception("Por favor, informe o campo Descricao!");
        }


if(isset($aFieldsStructure["descricao"]) && !isset($aFieldsStructure["descricao"]["isFk"]) && $aFieldsStructure["descricao"]["length"]){
    if (strlen($request->get("descricao")) > $aFieldsStructure["descricao"]["length"]) {
        $this->setMsg("Por favor, informe o campo Descricao corretamente, o tamanho do campo é {$aFieldsStructure["descricao"]["length"]}!");
        return false;
    }
}
        

        return true;
    }

    public function add($request, $commitable = true, $returnObject = false, $doLog = true) {
        foreach ($request->getParameters() as $i => $v) 
            $$i = $v;
        
        $oTemaIdioma = new TemaIdioma();
        $oTemaIdioma->setTema(QueryHelper::verifyObject($Tema, 'Tema', $this->em));
	$oTemaIdioma->setIdioma(QueryHelper::verifyObject($Idioma, 'Idioma', $this->em));
	$oTemaIdioma->setTitulo($titulo);
	$oTemaIdioma->setDescricao($descricao);
	
        try {
            if ($commitable) {
                $this->em->beginTransaction();
            }
            $this->em->persist($oTemaIdioma);
            $this->em->flush($oTemaIdioma);
            $this->addTransaction($oTemaIdioma, $request);
            
			
			if($doLog){
				
			}
			
            if ($commitable) {
                $this->em->commit();
            }
        } catch(Exception $e) {
            
            if ($commitable) {
                $this->em->rollback();
            }
            throw $e;
        }
        if($returnObject === true){
            return $oTemaIdioma;
        }
        return true;
    }

    protected function addTransaction($oTemaIdioma, $request){
    }

    public function edit($request, $commitable = true, $returnObject = false, $doLog = true) {
        foreach ($request->getParameters() as $i => $v) 
            $$i = $v;
        
        $oTemaIdioma = $this->em->find('TemaIdioma',array('Tema' => $Tema, 'Idioma' => $Idioma));
        $oTemaIdioma->setTitulo($titulo);
	$oTemaIdioma->setDescricao($descricao);
	

        try {
            if ($commitable) {
                $this->em->beginTransaction();
            }
            $this->em->persist($oTemaIdioma);
            $this->em->flush($oTemaIdioma);
            $this->editTransaction($oTemaIdioma, $request);
            
			
			if($doLog){
				
			}
			
            if ($commitable) {
                $this->em->commit();
            }
        } catch(Exception $e) {
            if ($commitable) {
                $this->em->rollback();
            }
            throw $e;
        }
        if($returnObject === true){
            return $oTemaIdioma;
        }
        return true;
    }

    protected function editTransaction($oTemaIdioma, $request){
    }

    

    public function paginatedCollection($fieldsToSelect = null, $page = 0, $resultsPerPage = 10, $conditions = null, $order = null, $distinct = FALSE, &$paginator = null) {
        /* @var $query \Doctrine\ORM\QueryBuilder */

        $queryHelper = new QueryHelper();
        $fieldsToSelect = $queryHelper->getSelectFields($fieldsToSelect);

        $qb = $this->em->createQueryBuilder();
        $query = $qb->select($fieldsToSelect)
            ->from('TemaIdioma', 'o');
		$query->distinct($distinct);

        if ($conditions) {
			$aConditions = is_array($conditions)?$conditions:array($conditions);			
			foreach ($aConditions as $condition) {
				$query->andWhere($condition);
            }
        }
		
        
        if(TemaIdiomaAction::manualOrder($query, $order) === FALSE){
            if($order) {
                if(strpos($order, " ") >= 0 && strpos($order, " ") !== FALSE){
                    list($order,$orderType) = explode(" ", $order, 2);
                }else{
                    $orderType = "ASC";
                }
                $entityPrefix = "o";
                if($order == 'Tema') {
                    $query->leftJoin('o.Tema', 'u');
                    $entityPrefix = "u";
                    $order = 'titulo';
                }if($order == 'Idioma') {
                    $query->leftJoin('o.Idioma', 'u');
                    $entityPrefix = "u";
                    $order = 'titulo';
                }
                $query->addOrderBy("{$entityPrefix}.{$order}",$orderType);
            }
        }
        $aObject = $query->getQuery()->setFirstResult($page)->setMaxResults($resultsPerPage)->execute();
        if ($fieldsToSelect !== "o") {
            $query->select("o");
        }
        $paginator = new Doctrine\ORM\Tools\Pagination\Paginator($query->getQuery()->setFirstResult($page)->setMaxResults($resultsPerPage), true);
        return $aObject;
    }

    public function collection($fieldsToSelect = null, $conditions = NULL, $order = NULL, $limit = NULL, $distinct = FALSE) {
        /* @var $query \Doctrine\ORM\QueryBuilder */

        $queryHelper = new QueryHelper();
        $fieldsToSelect = $queryHelper->getSelectFields($fieldsToSelect);

        $qb = $this->em->createQueryBuilder();
        $query = $qb->select($fieldsToSelect)
            ->from('TemaIdioma', 'o');
		$query->distinct($distinct);

        if ($conditions) {
			$aConditions = is_array($conditions)?$conditions:array($conditions);			
			foreach ($aConditions as $condition) {
				$query->andWhere($condition);
            }
        }
		
        
        if(TemaIdiomaAction::manualOrder($query, $order) === FALSE){
            if($order) {
                if(strpos($order, " ") >= 0 && strpos($order, " ") !== FALSE){
                    list($order,$orderType) = explode(" ", $order, 2);
                }else{
                    $orderType = "ASC";
                }
                $entityPrefix = "o";
if($order == 'Tema') {
                    $query->leftJoin('o.Tema', 'u');
                    $entityPrefix = "u";
                    $order = 'titulo';
                }if($order == 'Idioma') {
                    $query->leftJoin('o.Idioma', 'u');
                    $entityPrefix = "u";
                    $order = 'titulo';
                }
                $query->addOrderBy("{$entityPrefix}.{$order}",$orderType);
            }
        }
        if($limit !== NULL) {
            $query->setMaxResults($limit);
        }
        $itens = $query->getQuery()->getResult();
        if (count($itens) == 0) {
            return false;
        }
        return $itens;
    }

    public function totalRegistros($conditions = NULL) {
        /* @var $query \Doctrine\ORM\QueryBuilder */

        $qb = $this->em->createQueryBuilder();
        $query = $qb->select('count(o)')
            ->from('TemaIdioma', 'o');
        
        
		if ($conditions) {
			$aConditions = is_array($conditions)?$conditions:array($conditions);			
			foreach ($aConditions as $condition) {
				$query->andWhere($condition);
            }
        }
		
        $aTotal = $query->getQuery()->execute();
        return $aTotal[0][1];
    }

    public function select($Tema, $Idioma, $fieldsToSelect = null) {
        /* @var $query \Doctrine\ORM\QueryBuilder */
		$queryHelper = new QueryHelper();
        $fieldsToSelect = $queryHelper->getSelectFields($fieldsToSelect);

        $qb = $this->em->createQueryBuilder();
        $where = QueryHelper::getAndEquals(array('o.Tema' => $Tema, 'o.Idioma' => $Idioma), $qb);
        $query = $qb->select($fieldsToSelect)
            ->from('TemaIdioma', 'o')
            ->where( $where );
        
        $oTemaIdioma = $query->getQuery()->getOneOrNullResult();
        return $oTemaIdioma;
    }
	
	public function selectHistorico($Tema, $Idioma) {
        ### SELECT SEM LEVAR EM CONTA A DELEÇÃO LÓGICA ###
        /* @var $query \Doctrine\ORM\QueryBuilder */

        $qb = $this->em->createQueryBuilder();
        $where = QueryHelper::getAndEquals(array('o.Tema' => $Tema, 'o.Idioma' => $Idioma), $qb);
        $query = $qb->select('o')
            ->from('TemaIdioma', 'o')
            ->where( $where );
        $oTemaIdioma = $query->getQuery()->getOneOrNullResult();
        return $oTemaIdioma;
    }

    public function delLogical($Tema, $Idioma, $commitable = true, $doLog = true) {
        /* @var $query \Doctrine\ORM\QueryBuilder */

        $qb = $this->em->createQueryBuilder();
        $where = QueryHelper::getAndEquals(array('o.Tema' => $Tema, 'o.Idioma' => $Idioma), $qb);
        $query = $qb->update("TemaIdioma o")
            //->set([nome_atributo], 0)
            ->where( $where )->getQuery();

        try {
            if ($commitable) {
                $this->em->beginTransaction();
            }
            $this->delTransaction($Tema, $Idioma);
            $query->execute();
			
			if($doLog){
				
			}
			
            if ($commitable) {
                $this->em->commit();
            }
        } catch (Exception $e) {
            if ($commitable) {
                $this->em->rollback();
            }
            throw $e;
        }
        return true;
    }

    public function delPhysical($Tema, $Idioma, $commitable = true, $doLog = true) {
        /* @var $query \Doctrine\ORM\QueryBuilder */

        $qb = $this->em->createQueryBuilder();
        $where = QueryHelper::getAndEquals(array('o.Tema' => $Tema, 'o.Idioma' => $Idioma), $qb);
        $query = $qb->delete()->from("TemaIdioma", "o")
                ->where( $where )->getQuery();
        try {
            if ($commitable) {
                $this->em->beginTransaction();
            }
            $this->delTransaction($Tema, $Idioma);
            $query->execute();
			
			if($doLog){
				
			}

            
            
            if ($commitable) {
                $this->em->commit();
            }
        } catch (Exception $e) {
            if ($commitable) {
                $this->em->rollback();
            }
            throw $e;
        }
        return true;
    }

    protected function delTransaction($Tema, $Idioma){
    }

    public function delLogicalSelected($ids) {
        /* @var $query \Doctrine\ORM\QueryBuilder */

        try {
            $this->em->beginTransaction();
            foreach($ids as $id){
                $this->delLogical($id, false);
            }
            foreach($ids as $id){
                # apaga os arquivos
                
            }
            $this->em->commit();
        } catch (Exception $e) {
            $this->em->rollback();
            throw $e;
        }
        return true;
    }

    public function delPhysicalSelected($ids) {
        /* @var $query \Doctrine\ORM\QueryBuilder */

        try {
            $this->em->beginTransaction();
            foreach($ids as $id){
                $this->delPhysical($id, false);
            }
            foreach($ids as $id){
                # apaga os arquivos
                
            }
            $this->em->commit();
        } catch (Exception $e) {
            $this->em->rollback();
            throw $e;
        }
        return true;
    }

    public static function getEntityName(){
        return 'Tema Idioma';
    }

    public static function getTableName(){
        return 'tema_idioma';
    }

    public static function getModuleName() {
        return 'laboratoriovirtual';
    }
    
    public static function getClassName() {
        return 'TemaIdioma';
    }
    
    public static function getBaseUrl() {
        return URL . TemaIdiomaAction::getModuleName(). "/TemaIdioma/";
    }

    public static function manualOrder(&$query, $order) {
        return false;
    }
	
    public static function suggestDesc($o){
        return NULL;
    }
	
    public static function suggestDescHtml($o){
        return NULL;
    }

    public static function validateFields(){
        $aValidateFields = array('id_tema' => 'Tema', 'id_idioma' => 'Idioma', 'titulo' => 'titulo', 'descricao' => 'descricao');
        return (join(",", $aValidateFields));
    }

    public function toObject($v){
        $o = new TemaIdioma();
        $o->setTema((isset($v['Tema']) ? $this->em->find("Tema",array( 'id' => $v['Tema'])) : NULL));
        $o->setIdioma((isset($v['Idioma']) ? $this->em->find("Idioma",array( 'id' => $v['Idioma'])) : NULL));
        $o->setTitulo((isset($v['titulo']) ? $v['titulo'] : NULL));
        $o->setDescricao((isset($v['descricao']) ? $v['descricao'] : NULL));
        return $o;
    }

    public static function toArray($o){
        $v = array();
        $v['Tema'] = (($o->getTema()) ? TemaAction::toArray($o->getTema()) : NULL);
        $v['Idioma'] = (($o->getIdioma()) ? IdiomaAction::toArray($o->getIdioma()) : NULL);
        $v['titulo'] = $o->getTitulo();
        $v['descricao'] = $o->getDescricao();
        return $v;
    }

    public function getAdmFields(){
        return null;
    }

	public static function transformaColunas($conditions = null) {
        # tenta dar o replace nos campos ou retorna os campos senão tiver que substituir
        	$aFields['Tema'] = "id_tema";
	$conditions = preg_replace('~^Tema$~',"id_tema",$conditions);
	$aFields['Idioma'] = "id_idioma";
	$conditions = preg_replace('~^Idioma$~',"id_idioma",$conditions);
	$aFields['titulo'] = "titulo";
	$conditions = preg_replace('~^titulo$~',"titulo",$conditions);
	$aFields['descricao'] = "descricao";
	$conditions = preg_replace('~^descricao$~',"descricao",$conditions);
        if(!$conditions){
            return $aFields;
        }
        return $conditions;
    }
	
	public static function getKeys($tipo = null) {
        # F- FieldName || A- AttributeName
        @$aKeys = array('o.Tema' => $Tema, 'o.Idioma' => $Idioma); # @ pois poem as variaveis nao definidas e o importante é a chave
        $aCamposId = array_keys($aKeys);
        $aRet = array();
        foreach ($aCamposId as $o) {
            $attr = str_replace("o.", "", $o);
            $aRet["A"][] = $attr;
            $aRet["F"][] = TemaIdiomaAction::transformaColunas($attr);
        }
        if ($tipo == "F") {
            return implode(", ", $aRet["F"]);
        } else if ($tipo == "A") {
            return implode(", ", $aRet["A"]);
        }
        return $aRet;
    }
	
	public static function getFieldsTypeGenial($field = null) {
        # mostra o atributo que foi utilizado dos types do genial
		$aFields = array();
        	$aFields['Tema'] = array("suggest","titulo");
	$aFields['Idioma'] = array("suggest","titulo");
	$aFields['titulo'] = "str";
	$aFields['descricao'] = "memo";
        if($field){
            return $aFields[$field];
        }
        return $aFields;
    }
	
    

    
    

    public function validateDel($id, $isSingleDel = true){
		#$ids = is_array($id) ? $id : array($id);
        #foreach ($ids as $id_del) {
	
        if($isSingleDel){
            return true;
        }else{
            return true;
        }
    }
    
    public function filterConditions(&$request, &$response, &$orderPageConditions, $alias = "o", $conditions = array()){
        
        if($request->get('Tema')) {
            $conditions[] = "{$alias}.Tema = " . $request->get('Tema')  . "";
            $orderPageConditions .= "&Tema={$request->get('Tema')}";
            $response->set('Tema',  $request->get("Tema"));
        }
        if($request->get('TemaSuggest')) {
            $conditions[] = $response->get('TemaSuggestSQL'); // sql do campo mas ainda é necessário alterar o manualOrder e fazer join com a tabela
            $orderPageConditions .= "&TemaSuggest={$request->get('TemaSuggest')}";
            $response->set('TemaSuggest',  $request->get("TemaSuggest"));
        }
        if($request->get('Idioma')) {
            $conditions[] = "{$alias}.Idioma = " . $request->get('Idioma')  . "";
            $orderPageConditions .= "&Idioma={$request->get('Idioma')}";
            $response->set('Idioma',  $request->get("Idioma"));
        }
        if($request->get('IdiomaSuggest')) {
            $conditions[] = $response->get('IdiomaSuggestSQL'); // sql do campo mas ainda é necessário alterar o manualOrder e fazer join com a tabela
            $orderPageConditions .= "&IdiomaSuggest={$request->get('IdiomaSuggest')}";
            $response->set('IdiomaSuggest',  $request->get("IdiomaSuggest"));
        }

        return $conditions;
    }
	
	public static function getFieldsStructure($field = null){
        // ex: $aFieldsStructure = (Action::getFieldsStructure());
        $oAction = new TemaIdiomaAction();
        $entityManager = $oAction->getConnection();
        $aFields = QueryHelper::getFieldsForClass($oAction->getClassName(),$entityManager);
        if ($field) {
            if (isset($aFields[$field]))
                return $aFields[$field];
            else
                return NAO_DEFINIDO;
        }
        return $aFields;
    }
	
	public static function maxlengthFields() {
        $aFields = TemaIdiomaAction::getFieldsStructure();
        $aMaxlength = array();
        foreach ($aFields as $k => $o) {
            $aMaxlength[$k] = isset($o["length"]) ? $o["length"] : "";
        }
        return $aMaxlength;
    }
	
}
?>