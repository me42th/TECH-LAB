<?php namespace Tests\APIs;

use Illuminate\Foundation\Testing\WithoutMiddleware;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\TestCase;
use Tests\ApiTestTrait;
use App\Models\Texto;

class TextoApiTest extends TestCase
{
    use ApiTestTrait, WithoutMiddleware, DatabaseTransactions;

    /**
     * @test
     */
    public function test_create_texto()
    {
        $texto = factory(Texto::class)->make()->toArray();

        $this->response = $this->json(
            'POST',
            '/api/textos', $texto
        );

        $this->assertApiResponse($texto);
    }

    /**
     * @test
     */
    public function test_read_texto()
    {
        $texto = factory(Texto::class)->create();

        $this->response = $this->json(
            'GET',
            '/api/textos/'.$texto->id
        );

        $this->assertApiResponse($texto->toArray());
    }

    /**
     * @test
     */
    public function test_update_texto()
    {
        $texto = factory(Texto::class)->create();
        $editedTexto = factory(Texto::class)->make()->toArray();

        $this->response = $this->json(
            'PUT',
            '/api/textos/'.$texto->id,
            $editedTexto
        );

        $this->assertApiResponse($editedTexto);
    }

    /**
     * @test
     */
    public function test_delete_texto()
    {
        $texto = factory(Texto::class)->create();

        $this->response = $this->json(
            'DELETE',
             '/api/textos/'.$texto->id
         );

        $this->assertApiSuccess();
        $this->response = $this->json(
            'GET',
            '/api/textos/'.$texto->id
        );

        $this->response->assertStatus(404);
    }
}
