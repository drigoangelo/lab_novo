<?php
include_once(dirname(__FILE__).'/../actionparent/AlunoAtividadeActionParent.php');

class AlunoAtividadeAction extends AlunoAtividadeActionParent {

    public function validate(&$request,$edicao = false){
        # validação parent
        $validation = $this->validateParent($request,$edicao);
        if(!$validation){
           return $validation;
        }
        
        return true;
    }


}
?>