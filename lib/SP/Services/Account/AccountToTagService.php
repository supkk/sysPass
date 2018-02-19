<?php
/**
 * sysPass
 *
 * @author nuxsmin
 * @link http://syspass.org
 * @copyright 2012-2018, Rubén Domínguez nuxsmin@$syspass.org
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

namespace SP\Services\Account;

use SP\Repositories\Account\AccountToTagRepository;
use SP\Services\Service;

/**
 * Class AccountToTagService
 *
 * @package SP\Services\Account
 */
class AccountToTagService extends Service
{
    /**
     * @var AccountToTagRepository
     */
    protected $accountToTagRepository;

    /**
     * @throws \Psr\Container\ContainerExceptionInterface
     * @throws \Psr\Container\NotFoundExceptionInterface
     */
    protected function initialize()
    {
        $this->accountToTagRepository = $this->dic->get(AccountToTagRepository::class);
    }

    /**
     * @param $id
     * @return array
     */
    public function getTagsByAccountId($id)
    {
        return $this->accountToTagRepository->getTagsByAccountId($id);
    }

}