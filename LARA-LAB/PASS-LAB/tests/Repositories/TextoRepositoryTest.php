<?php namespace Tests\Repositories;

use App\Models\Texto;
use App\Repositories\TextoRepository;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\TestCase;
use Tests\ApiTestTrait;

class TextoRepositoryTest extends TestCase
{
    use ApiTestTrait, DatabaseTransactions;

    /**
     * @var TextoRepository
     */
    protected $textoRepo;

    public function setUp() : void
    {
        parent::setUp();
        $this->textoRepo = \App::make(TextoRepository::class);
    }

    /**
     * @test create
     */
    public function test_create_texto()
    {
        $texto = factory(Texto::class)->make()->toArray();

        $createdTexto = $this->textoRepo->create($texto);

        $createdTexto = $createdTexto->toArray();
        $this->assertArrayHasKey('id', $createdTexto);
        $this->assertNotNull($createdTexto['id'], 'Created Texto must have id specified');
        $this->assertNotNull(Texto::find($createdTexto['id']), 'Texto with given id must be in DB');
        $this->assertModelData($texto, $createdTexto);
    }

    /**
     * @test read
     */
    public function test_read_texto()
    {
        $texto = factory(Texto::class)->create();

        $dbTexto = $this->textoRepo->find($texto->id);

        $dbTexto = $dbTexto->toArray();
        $this->assertModelData($texto->toArray(), $dbTexto);
    }

    /**
     * @test update
     */
    public function test_update_texto()
    {
        $texto = factory(Texto::class)->create();
        $fakeTexto = factory(Texto::class)->make()->toArray();

        $updatedTexto = $this->textoRepo->update($fakeTexto, $texto->id);

        $this->assertModelData($fakeTexto, $updatedTexto->toArray());
        $dbTexto = $this->textoRepo->find($texto->id);
        $this->assertModelData($fakeTexto, $dbTexto->toArray());
    }

    /**
     * @test delete
     */
    public function test_delete_texto()
    {
        $texto = factory(Texto::class)->create();

        $resp = $this->textoRepo->delete($texto->id);

        $this->assertTrue($resp);
        $this->assertNull(Texto::find($texto->id), 'Texto should not exist in DB');
    }
}
