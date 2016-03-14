<?php
/**
 * sysPass
 *
 * @author    nuxsmin
 * @link      http://syspass.org
 * @copyright 2012-2016 Rubén Domínguez nuxsmin@$syspass.org
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
 * along with sysPass.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

namespace SP\DataModel;

defined('APP_ROOT') || die(_('No es posible acceder directamente a este archivo'));

/**
 * Class PublicLinkBaseData
 *
 * @package SP\DataModel
 */
class PublicLinkBaseData
{
    /**
     * @var int
     */
    public $publicLink_itemId = 0;
    /**
     * @var string
     */
    public $publicLink_hash = '';
    /**
     * @var PublicLinkData
     */
    public $publicLink_linkData = null;

    /**
     * @return int
     */
    public function getPublicLinkItemId()
    {
        return $this->publicLink_itemId;
    }

    /**
     * @param int $publicLink_itemId
     */
    public function setPublicLinkItemId($publicLink_itemId)
    {
        $this->publicLink_itemId = $publicLink_itemId;
    }

    /**
     * @return string
     */
    public function getPublicLinkHash()
    {
        return $this->publicLink_hash;
    }

    /**
     * @param string $publicLink_hash
     */
    public function setPublicLinkHash($publicLink_hash)
    {
        $this->publicLink_hash = $publicLink_hash;
    }

    /**
     * @return PublicLinkData
     */
    public function getPublicLinkLinkData()
    {
        return $this->publicLink_linkData;
    }

    /**
     * @param PublicLinkData $publicLink_linkData
     */
    public function setPublicLinkLinkData($publicLink_linkData)
    {
        $this->publicLink_linkData = $publicLink_linkData;
    }
}