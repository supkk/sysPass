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

namespace SP\Mgmt\Files;

use SP\Mgmt\ItemSearchInterface;
use SP\Storage\DB;
use SP\Storage\QueryData;

/**
 * Class FileSearch
 *
 * @package SP\Mgmt\Files
 */
class FileSearch extends FileBase implements ItemSearchInterface
{
    /**
     * @param        $limitCount
     * @param int    $limitStart
     * @param string $search
     * @return mixed
     */
    public function getMgmtSearch($limitCount, $limitStart = 0, $search = '')
    {
        $query = /** @lang SQL */
            'SELECT accfile_id,
            accfile_name,
            CONCAT(ROUND(accfile_size/1000, 2), "KB") AS accfile_size,
            accfile_thumb,
            accfile_type,
            account_name,
            customer_name
            FROM accFiles
            JOIN accounts ON account_id = accfile_accountId
            JOIN customers ON customer_id = account_customerId';

        $Data = new QueryData();
        $Data->setMapClassName('SP\DataModel\FileExtData');

        if (!empty($search)) {
            $query .= /** @lang SQL */
                ' WHERE accfile_name LIKE ?
                OR accfile_type LIKE ?
                OR account_name LIKE ?
                OR customer_name LIKE ?';

            $search = '%' . $search . '%';
            $Data->addParam($search);
            $Data->addParam($search);
            $Data->addParam($search);
            $Data->addParam($search);
        }

        $query .= /** @lang SQL */
            ' ORDER BY accfile_name LIMIT ?,?';

        $Data->addParam($limitStart);
        $Data->addParam($limitCount);

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