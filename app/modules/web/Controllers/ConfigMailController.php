<?php
/**
 * sysPass
 *
 * @author    nuxsmin
 * @link      http://syspass.org
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

namespace SP\Modules\Web\Controllers;

use SP\Core\Acl\ActionsInterface;
use SP\Core\Acl\UnauthorizedPageException;
use SP\Core\Events\Event;
use SP\Core\Exceptions\SPException;
use SP\Http\JsonResponse;
use SP\Http\Request;
use SP\Modules\Web\Controllers\Traits\ConfigTrait;

/**
 * Class ConfigMailController
 *
 * @package SP\Modules\Web\Controllers
 */
class ConfigMailController extends SimpleControllerBase
{
    use ConfigTrait;

    /**
     * @throws \SP\Core\Exceptions\InvalidArgumentException
     */
    public function saveAction()
    {
        $messages = [];
        $configData = clone $this->config->getConfigData();

        // Mail
        $mailEnabled = Request::analyze('mail_enabled', false, false, true);
        $mailServer = Request::analyze('mail_server');
        $mailPort = Request::analyze('mail_port', 25);
        $mailUser = Request::analyze('mail_user');
        $mailPass = Request::analyzeEncrypted('mail_pass');
        $mailSecurity = Request::analyze('mail_security');
        $mailFrom = Request::analyze('mail_from');
        $mailRequests = Request::analyze('mail_requestsenabled', false, false, true);
        $mailAuth = Request::analyze('mail_authenabled', false, false, true);

        // Valores para la configuración del Correo
        if ($mailEnabled && (!$mailServer || !$mailFrom)) {
            $this->returnJsonResponse(JsonResponse::JSON_ERROR, __u('Faltan parámetros de Correo'));
        }

        if ($mailEnabled) {
            $configData->setMailEnabled(true);
            $configData->setMailRequestsEnabled($mailRequests);
            $configData->setMailServer($mailServer);
            $configData->setMailPort($mailPort);
            $configData->setMailSecurity($mailSecurity);
            $configData->setMailFrom($mailFrom);

            if ($mailAuth) {
                $configData->setMailAuthenabled($mailAuth);
                $configData->setMailUser($mailUser);
                $configData->setMailPass($mailPass);
            }

            $messages[] = __u('Correo habiltado');
        } elseif ($configData->isMailEnabled()) {
            $configData->setMailEnabled(false);
            $configData->setMailRequestsEnabled(false);
            $configData->setMailAuthenabled(false);

            $messages[] = __u('Correo deshabilitado');
        }

        $this->eventDispatcher->notifyEvent('save.config.mail', new Event($this, $messages));

        $this->saveConfig($configData, $this->config);
    }

    protected function initialize()
    {
        try {
            if (!$this->checkAccess(ActionsInterface::MAIL_CONFIG)) {
                throw new UnauthorizedPageException(SPException::INFO);
            }
        } catch (UnauthorizedPageException $e) {
            $this->returnJsonResponseException($e);
        }
    }
}