<?php

class GameException extends Exception {
	public function errorMessage()
	{
		return $this->getMessage();
	}
}

?>