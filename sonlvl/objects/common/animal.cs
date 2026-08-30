using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Drawing;
using SonicRetro.SonLVL.API;
using SonicRetro.SonLVL.API.SCD;

namespace SCDObjectDefinitions.Common
{
	public class Animal : ObjectDefinition
	{
		private struct AnimalData
		{
			public string name;
			public Sprite sprite;
			public int depth;

			public AnimalData(string name, Sprite sprite, bool x_flip, int depth)
			{
				this.name = name;
				this.sprite = new Sprite(sprite, x_flip, false);
				this.depth = depth;
			}
		}

		private AnimalData[,] animals;

		public override void Init(ObjectData data)
		{
			animals = new AnimalData[7, 2];

			// R1
			byte[] art_file = ObjectHelper.OpenArtFile("../src/gfx/r1/animals.nem", CompressionType.Nemesis);
			animals[0, 0] = new AnimalData(
				"Flicky",
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/animal_1.asm", 0, 0, true),
				true, 4);
			animals[0, 1] = new AnimalData(
				"Squirrel",
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r1/animal_2.asm", 0, 0, false),
				false, 0);

			// R3
			art_file = ObjectHelper.OpenArtFile("../src/gfx/r3/animals.nem", CompressionType.Nemesis);
			animals[1, 0] = new AnimalData(
				"Canary",
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r3/animal_1.asm", 0, 0, true),
				true, 1);
			animals[1, 1] = new AnimalData(
				"Rabbit",
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r3/animal_2.asm", 0, 0, false),
				false, 0);

			// R4
			art_file = ObjectHelper.OpenArtFile("../src/gfx/r4/animals.nem", CompressionType.Nemesis);
			animals[2, 0] = new AnimalData(
				"Red Fish",
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r4/animal_1.asm", 0, 0, false),
				false, 5);
			animals[2, 1] = new AnimalData(
				"Green Fish",
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r4/animal_2.asm", 0, 1, false),
				false, 5);

			// R5
			art_file = ObjectHelper.OpenArtFile("../src/gfx/r5/animals.nem", CompressionType.Nemesis);
			animals[3, 0] = new AnimalData(
				"Flicky",
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r5/animal_1.asm", 0, 0, true),
				true, 4);
			animals[3, 1] = new AnimalData(
				"Squirrel",
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r5/animal_2.asm", 0, 0, false),
				false, 0);

			// R6
			art_file = ObjectHelper.OpenArtFile("../src/gfx/r6/animals.nem", CompressionType.Nemesis);
			animals[4, 0] = new AnimalData(
				"Swallow",
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r6/animal_1.asm", 0, 0, true),
				true, 1);
			animals[4, 1] = new AnimalData(
				"Penguin",
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r6/animal_2.asm", 0, 0, false),
				false, 0);

			// R7
			art_file = ObjectHelper.OpenArtFile("../src/gfx/r7/animals.nem", CompressionType.Nemesis);
			animals[5, 0] = new AnimalData(
				"Canary",
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r7/animal_1.asm", 0, 0, false),
				true, 0);
			animals[5, 1] = new AnimalData(
				"Rabbit",
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r7/animal_2.asm", 0, 0, false),
				false, 0);

			// R8
			art_file = ObjectHelper.OpenArtFile("../src/gfx/r8/animals.nem", CompressionType.Nemesis);
			animals[6, 0] = new AnimalData(
				"Dove",
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r8/animal_1.asm", 0, 0, false),
				true, 0);
			animals[6, 1] = new AnimalData(
				"Sheep",
				ObjectHelper.MapASMToBmp(art_file, "../src/sprites/r8/animal_2.asm", 0, 0, false),
				false, 0);
		}

		public override ReadOnlyCollection<byte> Subtypes
		{
			get { return new ReadOnlyCollection<byte>(new byte[] { 0, 1 }); }
		}

		public override string Name
		{
			get { return "Animal"; }
		}

		public override bool RememberState
		{
			get { return false; }
		}

		public override string SubtypeName(byte subtype)
		{
			return animals[LevelData.Level.Zone, subtype & 0x7F].name;
		}

		public override Sprite Image
		{
			get { return animals[LevelData.Level.Zone, 0].sprite; }
		}

		public override Sprite SubtypeImage(byte subtype)
		{
			return animals[LevelData.Level.Zone, subtype & 0x7F].sprite;
		}

		public override Sprite GetSprite(ObjectEntry obj)
		{
			bool x_flip = false;
			bool y_flip = false;
			if ((obj.SubType & 0x7F) == 0 || LevelData.Level.Zone == 2)
			{
				x_flip = obj.XFlip;
				y_flip = obj.YFlip;
			}
			return new Sprite(animals[LevelData.Level.Zone, obj.SubType & 0x7F].sprite, x_flip, y_flip);
		}
		
		public override int GetDepth(ObjectEntry obj)
		{
			return animals[LevelData.Level.Zone, obj.SubType & 0x7F].depth;
		}
	}
}
