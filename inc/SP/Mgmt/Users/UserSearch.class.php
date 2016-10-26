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

namespace SP\Mgmt\Users;

use SP\Core\Session;
use SP\DataModel\ItemSearchData;
use SP\Mgmt\ItemSearchInterface;
use SP\Storage\DB;
use SP\Storage\QueryData;

/**
 * Class UserSearch
 *
 * @package SP\Mgmt\Users
 */
class UserSearch extends UserBase implements ItemSearchInterface
{
    /**
     * @param ItemSearchData $SearchData
     * @return mixed
     */
    public function getMgmtSearch(ItemSearchData $SearchData)
    {
        $query = /** @lang SQL */
            'SELECT user_id,
            user_name, 
            user_login,
            userprofile_name,
            usergroup_name,
            BIN(user_isAdminApp) AS user_isAdminApp,
            BIN(user_isAdminAcc) AS user_isAdminAcc,
            BIN(user_isLdap) AS user_isLdap,
            BIN(user_isDisabled) AS user_isDisabled,
            BIN(user_isChangePass) AS user_isChangePass
            FROM usrData
            LEFT JOIN usrProfiles ON user_profileId = userprofile_id
            LEFT JOIN usrGroups ON usrData.user_groupId = usergroup_id';

        $Data = new QueryData();

        if ($SearchData->getSeachString() !== '') {

            $query .= /** @lang SQL */
                ' WHERE user_name LIKE ? OR user_login LIKE ?';

            $query .= (!Session::getUserIsAdminApp()) ? ' AND user_isAdminApp = 0' : '';

            $search = '%' . $SearchData->getSeachString() . '%';

            $Data->addParam($search);
            $Data->addParam($search);
        } else {
            $query .= (!Session::getUserIsAdminApp()) ? ' WHERE user_isAdminApp = 0' : '';
        }

        $query .= ' ORDER BY user_name';
        $query .= ' LIMIT ?, ?';

        $Data->addParam($SearchData->getLimitStart());
        $Data->addParam($SearchData->getLimitCount());

        $Data->setQuery($query);

        DB::setReturnArray();
        DB::setFullRowCount();

        $queryRes = DB::getResults($Data);

        if ($queryRes === false) {
            return array();
        }

        $queryRes['count'] = DB::$lastNumRows;

        return $queryRes;
    }
}