<?php namespace Tests\APIs;

use Illuminate\Foundation\Testing\WithoutMiddleware;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\TestCase;
use Tests\ApiTestTrait;
use App\Models\Autor;

class AutorApiTest extends TestCase
{
    use ApiTestTrait, WithoutMiddleware, DatabaseTransactions;

    /**
     * @test
     */
    public function test_create_autor()
    {
        $autor = factory(Autor::class)->make()->toArray();

        $this->response = $this->json(
            'POST',
            '/api/autors', $autor
        );

        $this->assertApiResponse($autor);
    }

    /**
     * @test
     */
    public function test_read_autor()
    {
        $autor = factory(Autor::class)->create();

        $this->response = $this->json(
            'GET',
            '/api/autors/'.$autor->id
        );

        $this->assertApiResponse($autor->toArray());
    }

    /**
     * @test
     */
    public function test_update_autor()
    {
        $autor = factory(Autor::class)->create();
        $editedAutor = factory(Autor::class)->make()->toArray();

        $this->response = $this->json(
            'PUT',
            '/api/autors/'.$autor->id,
            $editedAutor
        );

        $this->assertApiResponse($editedAutor);
    }

    /**
     * @test
     */
    public function test_delete_autor()
    {
        $autor = factory(Autor::class)->create();

        $this->response = $this->json(
            'DELETE',
             '/api/autors/'.$autor->id
         );

        $this->assertApiSuccess();
        $this->response = $this->json(
            'GET',
            '/api/autors/'.$autor->id
        );

        $this->response->assertStatus(404);
    }
}
