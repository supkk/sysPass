<?php
/**
 * sysPass
 *
 * @author nuxsmin
 * @link http://syspass.org
 * @copyright 2012-2017, Rubén Domínguez nuxsmin@$syspass.org
 *
 * This file is part of sysPass.
 *
 * sysPass is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * sysPass is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 *  along with sysPass.  If not, see <http://www.gnu.org/licenses/>.
 */

namespace SP\Import;

use SP\Core\Crypt;
use SP\Core\Exceptions\SPException;
use SP\DataModel\AccountExtData;
use SP\DataModel\CategoryData;
use SP\DataModel\CustomerData;
use SP\DataModel\TagData;

defined('APP_ROOT') || die(_('No es posible acceder directamente a este archivo'));

/**
 * Esta clase es la encargada de importar cuentas desde sysPass
 */
class SyspassImport extends XmlImportBase
{
    /**
     * Mapeo de etiquetas
     *
     * @var array
     */
    protected $tags = [];
    /**
     * Mapeo de categorías.
     *
     * @var array
     */
    protected $categories = [];
    /**
     * Mapeo de clientes.
     *
     * @var array
     */
    protected $customers = [];

    /**
     * Iniciar la importación desde sysPass.
     *
     * @throws SPException
     */
    public function doImport()
    {
        try {
            if ($this->detectEncrypted()) {
                if ($this->ImportParams->getImportPwd() === '') {
                    throw new SPException(SPException::SP_ERROR, _('Clave de encriptación no indicada'));
                }

                $this->processEncrypted();
            }
            $this->processCategories();
            $this->processCustomers();
            $this->processTags();
            $this->processAccounts();
        } catch (SPException $e) {
            throw $e;
        } catch (\DOMException $e) {
            throw new SPException(SPException::SP_CRITICAL, $e->getMessage());
        }
    }

    /**
     * Verificar si existen datos encriptados
     *
     * @return bool
     */
    protected function detectEncrypted()
    {
        return ($this->xmlDOM->getElementsByTagName('Encrypted')->length > 0);
    }

    /**
     * Procesar los datos encriptados y añadirlos al árbol DOM desencriptados
     */
    protected function processEncrypted()
    {
        foreach ($this->xmlDOM->getElementsByTagName('Data') as $node) {
            /** @var $node \DOMElement */
            $data = base64_decode($node->nodeValue);
            $iv = base64_decode($node->getAttribute('iv'));

            $xmlDecrypted = Crypt::getDecrypt($data, $iv, $this->ImportParams->getImportPwd());

            $newXmlData = new \DOMDocument();
//            $newXmlData->preserveWhiteSpace = true;
            $newXmlData->loadXML($xmlDecrypted);
            $newNode = $this->xmlDOM->importNode($newXmlData->documentElement, TRUE);

            $this->xmlDOM->documentElement->appendChild($newNode);
        }

        // Eliminar los datos encriptados tras desencriptar los mismos
        if ($this->xmlDOM->getElementsByTagName('Data')->length > 0) {
            $nodeData = $this->xmlDOM->getElementsByTagName('Encrypted')->item(0);
            $nodeData->parentNode->removeChild($nodeData);
        }
    }

    /**
     * Obtener las categorías y añadirlas a sysPass.
     *
     * @param \DOMElement $Category
     * @throws SPException
     * @throws \SP\Core\Exceptions\InvalidClassException
     */
    protected function processCategories(\DOMElement $Category = null)
    {
        if ($Category === null) {
            $this->getNodesData('Categories', 'Category', __FUNCTION__);
            return;
        }

        $CategoryData = new CategoryData();

        foreach ($Category->childNodes as $categoryNode) {
            if (isset($categoryNode->tagName)) {
                switch ($categoryNode->tagName) {
                    case 'name':
                        $CategoryData->setCategoryName($categoryNode->nodeValue);
                        break;
                    case 'description':
                        $CategoryData->setCategoryDescription($categoryNode->nodeValue);
                        break;
                }
            }
        }

        $this->addCategory($CategoryData);

        $this->categories[$Category->getAttribute('id')] = $CategoryData->getCategoryId();
    }

    /**
     * Obtener los clientes y añadirlos a sysPass.
     *
     * @param \DOMElement $Customer
     * @throws SPException
     * @throws \SP\Core\Exceptions\InvalidClassException
     */
    protected function processCustomers(\DOMElement $Customer = null)
    {
        if ($Customer === null) {
            $this->getNodesData('Customers', 'Customer', __FUNCTION__);
            return;
        }

        $CustomerData = new CustomerData();

        foreach ($Customer->childNodes as $customerNode) {
            if (isset($customerNode->tagName)) {
                switch ($customerNode->tagName) {
                    case 'name':
                        $CustomerData->setCustomerName($customerNode->nodeValue);
                        break;
                    case 'description':
                        $CustomerData->setCustomerDescription($customerNode->nodeValue);
                        break;
                }
            }
        }

        $this->addCustomer($CustomerData);

        $this->customers[$Customer->getAttribute('id')] = $CustomerData->getCustomerId();
    }

    /**
     * Obtener las etiquetas y añadirlas a sysPass.
     *
     * @param \DOMElement $Tag
     * @throws SPException
     * @throws \SP\Core\Exceptions\InvalidClassException
     */
    protected function processTags(\DOMElement $Tag = null)
    {
        if ($Tag === null) {
            $this->getNodesData('Tags', 'Tag', __FUNCTION__);
            return;
        }

        $TagData = new TagData();

        foreach ($Tag->childNodes as $tagNode) {
            if (isset($tagNode->tagName)) {
                switch ($tagNode->tagName) {
                    case 'name':
                        $TagData->setTagName($tagNode->nodeValue);
                        break;
                }
            }
        }

        $this->addTag($TagData);

        $this->tags[$Tag->getAttribute('id')] = $TagData->getTagId();
    }

    /**
     * Obtener los datos de las cuentas de sysPass y crearlas.
     *
     * @param \DOMElement $Account
     * @throws SPException
     */
    protected function processAccounts(\DOMElement $Account = null)
    {
        if ($Account === null) {
            $this->getNodesData('Accounts', 'Account', __FUNCTION__);
            return;
        }

        $AccountData = new AccountExtData();

        foreach ($Account->childNodes as $accountNode) {
            if (isset($accountNode->tagName)) {
                switch ($accountNode->tagName) {
                    case 'name';
                        $AccountData->setAccountName($accountNode->nodeValue);
                        break;
                    case 'login';
                        $AccountData->setAccountLogin($accountNode->nodeValue);
                        break;
                    case 'categoryId';
                        $AccountData->setAccountCategoryId($this->categories[(int)$accountNode->nodeValue]);
                        break;
                    case 'customerId';
                        $AccountData->setAccountCustomerId($this->customers[(int)$accountNode->nodeValue]);
                        break;
                    case 'url';
                        $AccountData->setAccountUrl($accountNode->nodeValue);
                        break;
                    case 'pass';
                        $AccountData->setAccountPass(base64_decode($accountNode->nodeValue));
                        break;
                    case 'passiv';
                        $AccountData->setAccountIV(base64_decode($accountNode->nodeValue));
                        break;
                    case 'notes';
                        $AccountData->setAccountNotes($accountNode->nodeValue);
                        break;
                }
            }
        }

        $this->addAccount($AccountData);
    }
}