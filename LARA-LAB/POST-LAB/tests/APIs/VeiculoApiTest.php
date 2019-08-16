<?php namespace Tests\APIs;

use Illuminate\Foundation\Testing\WithoutMiddleware;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\TestCase;
use Tests\ApiTestTrait;
use App\Models\Veiculo;

class VeiculoApiTest extends TestCase
{
    use ApiTestTrait, WithoutMiddleware, DatabaseTransactions;

    /**
     * @test
     */
    public function test_create_veiculo()
    {
        $veiculo = factory(Veiculo::class)->make()->toArray();

        $this->response = $this->json(
            'POST',
            '/api/veiculos', $veiculo
        );

        $this->assertApiResponse($veiculo);
    }

    /**
     * @test
     */
    public function test_read_veiculo()
    {
        $veiculo = factory(Veiculo::class)->create();

        $this->response = $this->json(
            'GET',
            '/api/veiculos/'.$veiculo->id
        );

        $this->assertApiResponse($veiculo->toArray());
    }

    /**
     * @test
     */
    public function test_update_veiculo()
    {
        $veiculo = factory(Veiculo::class)->create();
        $editedVeiculo = factory(Veiculo::class)->make()->toArray();

        $this->response = $this->json(
            'PUT',
            '/api/veiculos/'.$veiculo->id,
            $editedVeiculo
        );

        $this->assertApiResponse($editedVeiculo);
    }

    /**
     * @test
     */
    public function test_delete_veiculo()
    {
        $veiculo = factory(Veiculo::class)->create();

        $this->response = $this->json(
            'DELETE',
             '/api/veiculos/'.$veiculo->id
         );

        $this->assertApiSuccess();
        $this->response = $this->json(
            'GET',
            '/api/veiculos/'.$veiculo->id
        );

        $this->response->assertStatus(404);
    }
}
