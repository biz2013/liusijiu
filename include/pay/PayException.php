<?php
/**
 * API异常类
 * WDPHP.COM
 */
class PayException extends Exception {
	public function errorMessage()
	{
		return $this->getMessage();
	}
}
