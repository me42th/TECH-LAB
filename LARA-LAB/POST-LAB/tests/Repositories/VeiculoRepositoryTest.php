<?php namespace Tests\Repositories;

use App\Models\Veiculo;
use App\Repositories\VeiculoRepository;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\TestCase;
use Tests\ApiTestTrait;

class VeiculoRepositoryTest extends TestCase
{
    use ApiTestTrait, DatabaseTransactions;

    /**
     * @var VeiculoRepository
     */
    protected $veiculoRepo;

    public function setUp() : void
    {
        parent::setUp();
        $this->veiculoRepo = \App::make(VeiculoRepository::class);
    }

    /**
     * @test create
     */
    public function test_create_veiculo()
    {
        $veiculo = factory(Veiculo::class)->make()->toArray();

        $createdVeiculo = $this->veiculoRepo->create($veiculo);

        $createdVeiculo = $createdVeiculo->toArray();
        $this->assertArrayHasKey('id', $createdVeiculo);
        $this->assertNotNull($createdVeiculo['id'], 'Created Veiculo must have id specified');
        $this->assertNotNull(Veiculo::find($createdVeiculo['id']), 'Veiculo with given id must be in DB');
        $this->assertModelData($veiculo, $createdVeiculo);
    }

    /**
     * @test read
     */
    public function test_read_veiculo()
    {
        $veiculo = factory(Veiculo::class)->create();

        $dbVeiculo = $this->veiculoRepo->find($veiculo->id);

        $dbVeiculo = $dbVeiculo->toArray();
        $this->assertModelData($veiculo->toArray(), $dbVeiculo);
    }

    /**
     * @test update
     */
    public function test_update_veiculo()
    {
        $veiculo = factory(Veiculo::class)->create();
        $fakeVeiculo = factory(Veiculo::class)->make()->toArray();

        $updatedVeiculo = $this->veiculoRepo->update($fakeVeiculo, $veiculo->id);

        $this->assertModelData($fakeVeiculo, $updatedVeiculo->toArray());
        $dbVeiculo = $this->veiculoRepo->find($veiculo->id);
        $this->assertModelData($fakeVeiculo, $dbVeiculo->toArray());
    }

    /**
     * @test delete
     */
    public function test_delete_veiculo()
    {
        $veiculo = factory(Veiculo::class)->create();

        $resp = $this->veiculoRepo->delete($veiculo->id);

        $this->assertTrue($resp);
        $this->assertNull(Veiculo::find($veiculo->id), 'Veiculo should not exist in DB');
    }
}
