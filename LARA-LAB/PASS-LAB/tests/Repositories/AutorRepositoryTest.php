<?php namespace Tests\Repositories;

use App\Models\Autor;
use App\Repositories\AutorRepository;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Tests\TestCase;
use Tests\ApiTestTrait;

class AutorRepositoryTest extends TestCase
{
    use ApiTestTrait, DatabaseTransactions;

    /**
     * @var AutorRepository
     */
    protected $autorRepo;

    public function setUp() : void
    {
        parent::setUp();
        $this->autorRepo = \App::make(AutorRepository::class);
    }

    /**
     * @test create
     */
    public function test_create_autor()
    {
        $autor = factory(Autor::class)->make()->toArray();

        $createdAutor = $this->autorRepo->create($autor);

        $createdAutor = $createdAutor->toArray();
        $this->assertArrayHasKey('id', $createdAutor);
        $this->assertNotNull($createdAutor['id'], 'Created Autor must have id specified');
        $this->assertNotNull(Autor::find($createdAutor['id']), 'Autor with given id must be in DB');
        $this->assertModelData($autor, $createdAutor);
    }

    /**
     * @test read
     */
    public function test_read_autor()
    {
        $autor = factory(Autor::class)->create();

        $dbAutor = $this->autorRepo->find($autor->id);

        $dbAutor = $dbAutor->toArray();
        $this->assertModelData($autor->toArray(), $dbAutor);
    }

    /**
     * @test update
     */
    public function test_update_autor()
    {
        $autor = factory(Autor::class)->create();
        $fakeAutor = factory(Autor::class)->make()->toArray();

        $updatedAutor = $this->autorRepo->update($fakeAutor, $autor->id);

        $this->assertModelData($fakeAutor, $updatedAutor->toArray());
        $dbAutor = $this->autorRepo->find($autor->id);
        $this->assertModelData($fakeAutor, $dbAutor->toArray());
    }

    /**
     * @test delete
     */
    public function test_delete_autor()
    {
        $autor = factory(Autor::class)->create();

        $resp = $this->autorRepo->delete($autor->id);

        $this->assertTrue($resp);
        $this->assertNull(Autor::find($autor->id), 'Autor should not exist in DB');
    }
}
