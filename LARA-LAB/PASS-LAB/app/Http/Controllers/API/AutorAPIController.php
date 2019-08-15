<?php

namespace App\Http\Controllers\API;

use App\Http\Requests\API\CreateAutorAPIRequest;
use App\Http\Requests\API\UpdateAutorAPIRequest;
use App\Models\Autor;
use App\Repositories\AutorRepository;
use Illuminate\Http\Request;
use App\Http\Controllers\AppBaseController;
use Response;

/**
 * Class AutorController
 * @package App\Http\Controllers\API
 */

class AutorAPIController extends AppBaseController
{
    /** @var  AutorRepository */
    private $autorRepository;

    public function __construct(AutorRepository $autorRepo)
    {
        $this->autorRepository = $autorRepo;
    }

    /**
     * @param Request $request
     * @return Response
     *
     * @SWG\Get(
     *      path="/autors",
     *      summary="Get a listing of the Autors.",
     *      tags={"Autor"},
     *      description="Get all Autors",
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
     *                  @SWG\Items(ref="#/definitions/Autor")
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
        $autors = $this->autorRepository->all(
            $request->except(['skip', 'limit']),
            $request->get('skip'),
            $request->get('limit')
        );

        return $this->sendResponse($autors->toArray(), 'Autors retrieved successfully');
    }

    /**
     * @param CreateAutorAPIRequest $request
     * @return Response
     *
     * @SWG\Post(
     *      path="/autors",
     *      summary="Store a newly created Autor in storage",
     *      tags={"Autor"},
     *      description="Store Autor",
     *      produces={"application/json"},
     *      @SWG\Parameter(
     *          name="body",
     *          in="body",
     *          description="Autor that should be stored",
     *          required=false,
     *          @SWG\Schema(ref="#/definitions/Autor")
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
     *                  ref="#/definitions/Autor"
     *              ),
     *              @SWG\Property(
     *                  property="message",
     *                  type="string"
     *              )
     *          )
     *      )
     * )
     */
    public function store(CreateAutorAPIRequest $request)
    {
        $input = $request->all();

        $autor = $this->autorRepository->create($input);

        return $this->sendResponse($autor->toArray(), 'Autor saved successfully');
    }

    /**
     * @param int $id
     * @return Response
     *
     * @SWG\Get(
     *      path="/autors/{id}",
     *      summary="Display the specified Autor",
     *      tags={"Autor"},
     *      description="Get Autor",
     *      produces={"application/json"},
     *      @SWG\Parameter(
     *          name="id",
     *          description="id of Autor",
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
     *                  ref="#/definitions/Autor"
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
        /** @var Autor $autor */
        $autor = $this->autorRepository->find($id);

        if (empty($autor)) {
            return $this->sendError('Autor not found');
        }

        return $this->sendResponse($autor->toArray(), 'Autor retrieved successfully');
    }

    /**
     * @param int $id
     * @param UpdateAutorAPIRequest $request
     * @return Response
     *
     * @SWG\Put(
     *      path="/autors/{id}",
     *      summary="Update the specified Autor in storage",
     *      tags={"Autor"},
     *      description="Update Autor",
     *      produces={"application/json"},
     *      @SWG\Parameter(
     *          name="id",
     *          description="id of Autor",
     *          type="integer",
     *          required=true,
     *          in="path"
     *      ),
     *      @SWG\Parameter(
     *          name="body",
     *          in="body",
     *          description="Autor that should be updated",
     *          required=false,
     *          @SWG\Schema(ref="#/definitions/Autor")
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
     *                  ref="#/definitions/Autor"
     *              ),
     *              @SWG\Property(
     *                  property="message",
     *                  type="string"
     *              )
     *          )
     *      )
     * )
     */
    public function update($id, UpdateAutorAPIRequest $request)
    {
        $input = $request->all();

        /** @var Autor $autor */
        $autor = $this->autorRepository->find($id);

        if (empty($autor)) {
            return $this->sendError('Autor not found');
        }

        $autor = $this->autorRepository->update($input, $id);

        return $this->sendResponse($autor->toArray(), 'Autor updated successfully');
    }

    /**
     * @param int $id
     * @return Response
     *
     * @SWG\Delete(
     *      path="/autors/{id}",
     *      summary="Remove the specified Autor from storage",
     *      tags={"Autor"},
     *      description="Delete Autor",
     *      produces={"application/json"},
     *      @SWG\Parameter(
     *          name="id",
     *          description="id of Autor",
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
        /** @var Autor $autor */
        $autor = $this->autorRepository->find($id);

        if (empty($autor)) {
            return $this->sendError('Autor not found');
        }

        $autor->delete();

        return $this->sendResponse($id, 'Autor deleted successfully');
    }
}
