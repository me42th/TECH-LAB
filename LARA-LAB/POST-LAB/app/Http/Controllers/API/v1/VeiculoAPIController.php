<?php

namespace App\Http\Controllers\API\v1;

use App\Http\Requests\API\CreateVeiculoAPIRequest;
use App\Http\Requests\API\UpdateVeiculoAPIRequest;
use App\Models\Veiculo;
use App\Repositories\VeiculoRepository;
use Illuminate\Http\Request;
use App\Http\Controllers\AppBaseController;
use Response;

/**
 * Class VeiculoController
 * @package App\Http\Controllers\API
 */

class VeiculoAPIController extends AppBaseController
{
    /** @var  VeiculoRepository */
    private $veiculoRepository;

    public function __construct(VeiculoRepository $veiculoRepo)
    {
        $this->veiculoRepository = $veiculoRepo;
    }

    /**
     * @param Request $request
     * @return Response
     *
     * @SWG\Get(
     *      path="/veiculos",
     *      summary="Get a listing of the Veiculos.",
     *      tags={"Veiculo"},
     *      description="Get all Veiculos",
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
     *                  @SWG\Items(ref="#/definitions/Veiculo")
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
        $veiculos = $this->veiculoRepository->all(
            $request->except(['skip', 'limit']),
            $request->get('skip'),
            $request->get('limit')
        );

        return $this->sendResponse($veiculos->toArray(), 'Veiculos retrieved successfully');
    }

    /**
     * @param CreateVeiculoAPIRequest $request
     * @return Response
     *
     * @SWG\Post(
     *      path="/veiculos",
     *      summary="Store a newly created Veiculo in storage",
     *      tags={"Veiculo"},
     *      description="Store Veiculo",
     *      produces={"application/json"},
     *      @SWG\Parameter(
     *          name="body",
     *          in="body",
     *          description="Veiculo that should be stored",
     *          required=false,
     *          @SWG\Schema(ref="#/definitions/Veiculo")
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
     *                  ref="#/definitions/Veiculo"
     *              ),
     *              @SWG\Property(
     *                  property="message",
     *                  type="string"
     *              )
     *          )
     *      )
     * )
     */
    public function store(CreateVeiculoAPIRequest $request)
    {
        $input = $request->all();

        $veiculo = $this->veiculoRepository->create($input);

        return $this->sendResponse($veiculo->toArray(), 'Veiculo saved successfully');
    }

    /**
     * @param int $id
     * @return Response
     *
     * @SWG\Get(
     *      path="/veiculos/{id}",
     *      summary="Display the specified Veiculo",
     *      tags={"Veiculo"},
     *      description="Get Veiculo",
     *      produces={"application/json"},
     *      @SWG\Parameter(
     *          name="id",
     *          description="id of Veiculo",
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
     *                  ref="#/definitions/Veiculo"
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
        /** @var Veiculo $veiculo */
        $veiculo = $this->veiculoRepository->find($id);

        if (empty($veiculo)) {
            return $this->sendError('Veiculo not found');
        }

        return $this->sendResponse($veiculo->toArray(), 'Veiculo retrieved successfully');
    }

    /**
     * @param int $id
     * @param UpdateVeiculoAPIRequest $request
     * @return Response
     *
     * @SWG\Put(
     *      path="/veiculos/{id}",
     *      summary="Update the specified Veiculo in storage",
     *      tags={"Veiculo"},
     *      description="Update Veiculo",
     *      produces={"application/json"},
     *      @SWG\Parameter(
     *          name="id",
     *          description="id of Veiculo",
     *          type="integer",
     *          required=true,
     *          in="path"
     *      ),
     *      @SWG\Parameter(
     *          name="body",
     *          in="body",
     *          description="Veiculo that should be updated",
     *          required=false,
     *          @SWG\Schema(ref="#/definitions/Veiculo")
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
     *                  ref="#/definitions/Veiculo"
     *              ),
     *              @SWG\Property(
     *                  property="message",
     *                  type="string"
     *              )
     *          )
     *      )
     * )
     */
    public function update($id, UpdateVeiculoAPIRequest $request)
    {
        $input = $request->all();

        /** @var Veiculo $veiculo */
        $veiculo = $this->veiculoRepository->find($id);

        if (empty($veiculo)) {
            return $this->sendError('Veiculo not found');
        }

        $veiculo = $this->veiculoRepository->update($input, $id);

        return $this->sendResponse($veiculo->toArray(), 'Veiculo updated successfully');
    }

    /**
     * @param int $id
     * @return Response
     *
     * @SWG\Delete(
     *      path="/veiculos/{id}",
     *      summary="Remove the specified Veiculo from storage",
     *      tags={"Veiculo"},
     *      description="Delete Veiculo",
     *      produces={"application/json"},
     *      @SWG\Parameter(
     *          name="id",
     *          description="id of Veiculo",
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
        /** @var Veiculo $veiculo */
        $veiculo = $this->veiculoRepository->find($id);

        if (empty($veiculo)) {
            return $this->sendError('Veiculo not found');
        }

        $veiculo->delete();

        return $this->sendResponse($id, 'Veiculo deleted successfully');
    }
}
