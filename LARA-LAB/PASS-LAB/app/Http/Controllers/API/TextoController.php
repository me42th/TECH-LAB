<?php

namespace App\Http\Controllers\API;

use App\Http\Requests\API\CreateTextoAPIRequest;
use App\Http\Requests\API\UpdateTextoAPIRequest;
use App\Models\Texto;
use App\Repositories\TextoRepository;
use Illuminate\Http\Request;
use App\Http\Controllers\AppBaseController;
use Response;

/**
 * Class TextoController
 * @package App\Http\Controllers\API
 */

class TextoController extends AppBaseController
{
    /** @var  TextoRepository */
    private $textoRepository;

    public function __construct(TextoRepository $textoRepo)
    {
        $this->textoRepository = $textoRepo;
    }

    /**
     * @param Request $request
     * @return Response
     *
     * @SWG\Get(
     *      path="/textos",
     *      summary="Lista dos textos deste autor.",
     *      tags={"Texto"},
     *      description="Get all Textos",
     *      produces={"application/json"},
     *      @SWG\Response(
     *          response=200,
     *          description="successful operation",
     *          @SWG\Schema(
     *              type="object",
     *              @SWG\Property(
     *                  property="success",
     *                  type="boolean"
     *              ),
     *              @SWG\Property(
     *                  property="data",
     *                  type="array",
     *                  @SWG\Items(ref="#/definitions/Texto")
     *              ),
     *              @SWG\Property(
     *                  property="message",
     *                  type="string"
     *              )
     *          )
     *      )
     * )
     */
    public function index(Request $request)
    {
        $textos = $this->textoRepository->all(
            $request->except(['skip', 'limit']),
            $request->get('skip'),
            $request->get('limit')
        );

        return $this->sendResponse($textos->toArray(), 'Textos retrieved successfully');
    }

    /**
     * @param CreateTextoAPIRequest $request
     * @return Response
     *
     * @SWG\Post(
     *      path="/textos",
     *      summary="Store a newly created Texto in storage",
     *      tags={"Texto"},
     *      description="Store Texto",
     *      produces={"application/json"},
     *      @SWG\Parameter(
     *          name="body",
     *          in="body",
     *          description="Texto that should be stored",
     *          required=false,
     *          @SWG\Schema(ref="#/definitions/Texto")
     *      ),
     *      @SWG\Response(
     *          response=200,
     *          description="successful operation",
     *          @SWG\Schema(
     *              type="object",
     *              @SWG\Property(
     *                  property="success",
     *                  type="boolean"
     *              ),
     *              @SWG\Property(
     *                  property="data",
     *                  ref="#/definitions/Texto"
     *              ),
     *              @SWG\Property(
     *                  property="message",
     *                  type="string"
     *              )
     *          )
     *      )
     * )
     */
    public function store(CreateTextoAPIRequest $request)
    {
        $input = $request->all();

        $texto = $this->textoRepository->create($input);

        return $this->sendResponse($texto->toArray(), 'Texto saved successfully');
    }

    /**
     * @param int $id
     * @return Response
     * @SwaggerDefinition(
     *    securityDefinition = @SecurityDefinition(
     *   apiKeyAuthDefinitions = {
     *    @ApiKeyAuthDefinition(key = "user", name = "Authorization", in = ApiKeyLocation.HEADER)
     *        }
     *        )
     *   )
     */
    public function shower($id)
    {
        /** @var Texto $texto */
        $texto = $this->textoRepository->find($id);

        if (empty($texto)) {
            return $this->sendError('Texto not found');
        }

        return $this->sendResponse($texto->toArray(), 'Texto retrieved successfully');
    }

    /**
     * @param int $id
     * @return Response
     *
     * @SWG\Get(
     *      path="/textos/{id}",
     *      summary="TESTE",
     *      tags={"Texto"},
     *      description="Get Texto",
     *      produces={"application/json"},
     *      @SWG\Parameter(
     *          name="id",
     *          description="id of Texto",
     *          type="integer",
     *          required=true,
     *          in="path"
     *      ),
     *      @SWG\Response(
     *          response=200,
     *          description="successful operation",
     *          @SWG\Schema(
     *              type="object",
     *              @SWG\Property(
     *                  property="success",
     *                  type="boolean"
     *              ),
     *              @SWG\Property(
     *                  property="data",
     *                  ref="#/definitions/Texto"
     *              ),
     *              @SWG\Property(
     *                  property="message",
     *                  type="string"
     *              )
     *          )
     *      )
     * )
     */
    public function show($id)
    {
        /** @var Texto $texto */
        $texto = $this->textoRepository->find($id);

        if (empty($texto)) {
            return $this->sendError('Texto not found');
        }

        return $this->sendResponse($texto->toArray(), 'Texto retrieved successfully');
    }

    /**
     * @param int $id
     * @param UpdateTextoAPIRequest $request
     * @return Response
     *
     * @SWG\Put(
     *      path="/textos/{id}",
     *      summary="Update the specified Texto in storage",
     *      tags={"Texto"},
     *      description="Update Texto",
     *      produces={"application/json"},
     *      @SWG\Parameter(
     *          name="id",
     *          description="id of Texto",
     *          type="integer",
     *          required=true,
     *          in="path"
     *      ),
     *      @SWG\Parameter(
     *          name="body",
     *          in="body",
     *          description="Texto that should be updated",
     *          required=false,
     *          @SWG\Schema(ref="#/definitions/Texto")
     *      ),
     *      @SWG\Response(
     *          response=200,
     *          description="successful operation",
     *          @SWG\Schema(
     *              type="object",
     *              @SWG\Property(
     *                  property="success",
     *                  type="boolean"
     *              ),
     *              @SWG\Property(
     *                  property="data",
     *                  ref="#/definitions/Texto"
     *              ),
     *              @SWG\Property(
     *                  property="message",
     *                  type="string"
     *              )
     *          )
     *      )
     * )
     */
    public function update($id, UpdateTextoAPIRequest $request)
    {
        $input = $request->all();

        /** @var Texto $texto */
        $texto = $this->textoRepository->find($id);

        if (empty($texto)) {
            return $this->sendError('Texto not found');
        }

        $texto = $this->textoRepository->update($input, $id);

        return $this->sendResponse($texto->toArray(), 'Texto updated successfully');
    }

    /**
     * @param int $id
     * @return Response
     *
     * @SWG\Delete(
     *      path="/textos/{id}",
     *      summary="Remove the specified Texto from storage",
     *      tags={"Texto"},
     *      description="Delete Texto",
     *      produces={"application/json"},
     *      @SWG\Parameter(
     *          name="id",
     *          description="id of Texto",
     *          type="integer",
     *          required=true,
     *          in="path"
     *      ),
     *      @SWG\Response(
     *          response=200,
     *          description="successful operation",
     *          @SWG\Schema(
     *              type="object",
     *              @SWG\Property(
     *                  property="success",
     *                  type="boolean"
     *              ),
     *              @SWG\Property(
     *                  property="data",
     *                  type="string"
     *              ),
     *              @SWG\Property(
     *                  property="message",
     *                  type="string"
     *              )
     *          )
     *      )
     * )
     */
    public function destroy($id)
    {
        /** @var Texto $texto */
        $texto = $this->textoRepository->find($id);

        if (empty($texto)) {
            return $this->sendError('Texto not found');
        }

        $texto->delete();

        return $this->sendResponse($id, 'Texto deleted successfully');
    }
}
