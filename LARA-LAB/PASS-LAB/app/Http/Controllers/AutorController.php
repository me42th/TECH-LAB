<?php

namespace App\Http\Controllers;

use App\Http\Requests\CreateAutorRequest;
use App\Http\Requests\UpdateAutorRequest;
use App\Repositories\AutorRepository;
use App\Http\Controllers\AppBaseController;
use Illuminate\Http\Request;
use Flash;
use Response;

class AutorController extends AppBaseController
{
    /** @var  AutorRepository */
    private $autorRepository;

    public function __construct(AutorRepository $autorRepo)
    {
        $this->autorRepository = $autorRepo;
    }

    /**
     * Display a listing of the Autor.
     *
     * @param Request $request
     *
     * @return Response
     */
    public function index(Request $request)
    {
        $autors = $this->autorRepository->all();

        return view('autors.index')
            ->with('autors', $autors);
    }

    /**
     * Show the form for creating a new Autor.
     *
     * @return Response
     */
    public function create()
    {
        return view('autors.create');
    }

    /**
     * Store a newly created Autor in storage.
     *
     * @param CreateAutorRequest $request
     *
     * @return Response
     */
    public function store(CreateAutorRequest $request)
    {
        $input = $request->all();

        $autor = $this->autorRepository->create($input);

        Flash::success('Autor saved successfully.');

        return redirect(route('autors.index'));
    }

    /**
     * Display the specified Autor.
     *
     * @param int $id
     *
     * @return Response
     */
    public function show($id)
    {
        $autor = $this->autorRepository->find($id);

        if (empty($autor)) {
            Flash::error('Autor not found');

            return redirect(route('autors.index'));
        }

        return view('autors.show')->with('autor', $autor);
    }

    /**
     * Show the form for editing the specified Autor.
     *
     * @param int $id
     *
     * @return Response
     */
    public function edit($id)
    {
        $autor = $this->autorRepository->find($id);

        if (empty($autor)) {
            Flash::error('Autor not found');

            return redirect(route('autors.index'));
        }

        return view('autors.edit')->with('autor', $autor);
    }

    /**
     * Update the specified Autor in storage.
     *
     * @param int $id
     * @param UpdateAutorRequest $request
     *
     * @return Response
     */
    public function update($id, UpdateAutorRequest $request)
    {
        $autor = $this->autorRepository->find($id);

        if (empty($autor)) {
            Flash::error('Autor not found');

            return redirect(route('autors.index'));
        }

        $autor = $this->autorRepository->update($request->all(), $id);

        Flash::success('Autor updated successfully.');

        return redirect(route('autors.index'));
    }

    /**
     * Remove the specified Autor from storage.
     *
     * @param int $id
     *
     * @throws \Exception
     *
     * @return Response
     */
    public function destroy($id)
    {
        $autor = $this->autorRepository->find($id);

        if (empty($autor)) {
            Flash::error('Autor not found');

            return redirect(route('autors.index'));
        }

        $this->autorRepository->delete($id);

        Flash::success('Autor deleted successfully.');

        return redirect(route('autors.index'));
    }
}
